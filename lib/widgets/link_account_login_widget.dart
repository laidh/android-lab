import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/models/social_media_type.dart';
import 'package:volunteer/screens/login_screen.dart';
import 'package:volunteer/widgets/email_login_widget.dart';
import 'package:volunteer/widgets/social_login_widget.dart';

class LinkAccountLoginWidget extends StatelessWidget {
  final String newSocialLoginMethodName;
  final String? email;
  final List<String> userSignInMethods;
  final AuthCredential pendingCredential;

  LinkAccountLoginWidget(this.newSocialLoginMethodName,
      {required this.email,
      required this.userSignInMethods,
      required this.pendingCredential});

  @override
  Widget build(BuildContext context) {
    if (userSignInMethods.isEmpty) {
      return LoginScreen();
    }

    List<SocialMediaType> socialMediaTypes = [];

    if (userSignInMethods.contains('google.com')) {
      socialMediaTypes.add(SocialMediaType.GOOGLE);
    }

    if (userSignInMethods.contains('apple.com')) {
      socialMediaTypes.add(SocialMediaType.APPLE);
    }

    if (userSignInMethods.contains('facebook.com')) {
      socialMediaTypes.add(SocialMediaType.FACEBOOK);
    }

    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Text(
              'У вас уже є акаунт',
              style: TextStyle(color: Colors.pink, fontSize: 18.0),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
                "Увійдіть одним з методів нижче, щоб під'єднати $newSocialLoginMethodName до вашого профілю.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey, fontSize: 14.0)),
            if (userSignInMethods.contains('password'))
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 16.0,
                  ),
                  EmailLoginWidget(
                      email: email,
                      onSignedIn: (userCredential) async {
                        await userCredential?.user
                            ?.linkWithCredential(pendingCredential);
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text('- АБО -'),
                ],
              ),
            SizedBox(
              height: 16.0,
            ),
            SocialLoginWidget(
                socialMediaTypes: socialMediaTypes,
                onSignedIn: (userCredential) async {
                  await userCredential?.user
                      ?.linkWithCredential(pendingCredential);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$newSocialLoginMethodName під'єднано."),
                  ));

                  Navigator.pop(context);
                }),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
