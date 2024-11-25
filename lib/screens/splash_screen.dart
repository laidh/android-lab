import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:volunteer/bl/notifications_manager.dart';
import 'package:volunteer/models/users/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer/providers/main_provider.dart';
import 'package:volunteer/screens/registration_screen.dart';
import 'package:volunteer/screens/home/home_screen.dart';
import 'package:volunteer/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final CollectionReference<User> usersCollection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson());

  @override
  void initState() {
    super.initState();

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen((String token) async {
      // Assume user is logged in for this example
      String? userId = firebase.FirebaseAuth.instance.currentUser?.uid;

      await usersCollection.doc(userId).update({
        'tokens': FieldValue.arrayUnion([token]),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<firebase.User?>(
          stream: firebase.FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return LoginScreen();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            var user = snapshot.data;

            if (user == null) {
              log('User is signed out.');
              return LoginScreen();
            } else {
              log('Signed in user: $user');

              if (!user.emailVerified) {
                return LoginScreen();
              }

              return FutureBuilder<DocumentSnapshot<User>>(
                  future: usersCollection.doc(user.uid).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return LoginScreen();
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }

                    if (snapshot.data == null) {
                      return Container();
                    }

                    if (!snapshot.data!.exists) {
                      return RegistrationScreen();
                    }

                    Future.microtask(() {
                      context.read<MainProvider>().userReference =
                          snapshot.data!.reference;

                      NotificationsManager.init(context);
                    });

                    return HomeScreen();
                  });
            }
          }),
    );
  }
}
