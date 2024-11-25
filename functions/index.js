const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
});

/**
 * Listen for new polls added to /polls/:id and send push messages to all users
 */
exports.sendNewPollNotification =
  functions
      .region("europe-west1")
      .firestore
      .document("/polls/{id}")
      .onCreate(async (snapshot, context) => {
        const firestore = admin.firestore();
        const title = snapshot.data().title;

        // Retrieve tokens for all users.
        const users = await firestore.collection("users").get();
        const tokens = users
            .docs
            .flatMap((doc) => doc.get("tokens"))
            .filter((token) => token);

        functions.logger.log(
            "There are",
            users.docs.length,
            "users and",
            tokens.length,
            "tokens",
            "to send notifications to.",
        );

        // Message details.
        const message = {
          tokens: tokens,
          notification: {
            title: "Нове опитування!",
            body: `${title}`,
          },
          data: {
            type: "new-poll",
            data: JSON.stringify({
              id: snapshot.data().id,
            }),
          },
          // High Android notification priority
          android: {
            priority: "high",
          },
          // APNS config
          apns: {
            payload: {
              aps: {
                contentAvailable: true,
              },
            },
            headers: {
              "apns-push-type": "background",
              // Must be `5` when `contentAvailable` is set to true.
              "apns-priority": "5",
              // bundle identifier
              "apns-topic": "com.olegnovosad.volunteer",
            },
          },
        };

        return admin.messaging().sendMulticast(message).then((response) => {
          console.log("Successfully sent message:", response);

          if (response.failureCount > 0) {
            response.responses.forEach((resp, index) => {
              const error = resp.error;
              if (error) {
                functions.logger.error(
                    "Failure sending notification to",
                    tokens[index],
                    error,
                );

                // Cleanup the tokens who are not registered anymore.
                if (error.code === "messaging/invalid-registration-token" ||
            error.code === "messaging/registration-token-not-registered") {
                  users.docs.forEach((doc) =>
                    doc.ref.update({
                      "tokens": firestore.FieldValue.arrayRemove(tokens[index]),
                    }),
                  );
                }
              }
            });
          }
        });
      });
