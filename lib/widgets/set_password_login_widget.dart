import 'package:flutter/material.dart';
import 'package:volunteer/models/social_media_type.dart';
import 'package:volunteer/screens/login_screen.dart';
import 'package:volunteer/widgets/social_login_widget.dart';

class SetPasswordLoginWidget extends StatelessWidget {
  final String email;
  final String password;
  final List<String> userSignInMethods;

  SetPasswordLoginWidget(
      {required this.email,
      required this.password,
      required this.userSignInMethods});

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
                "Увійдіть одним з методів нижче, щоб встановити пароль до вашого профілю.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey, fontSize: 14.0)),
            SizedBox(
              height: 16.0,
            ),
            SocialLoginWidget(
                socialMediaTypes: socialMediaTypes,
                onSignedIn: (userCredential) async {
                  await userCredential?.user?.updatePassword(password);
                  await userCredential?.user?.sendEmailVerification();

                  var emailVerified =
                      userCredential?.user?.emailVerified ?? false;
                  var text = emailVerified
                      ? 'Пароль встановлено.'
                      : 'Пароль встановлено. Підтвердіть вашу електронну скриньку, аби входити з допомогою паролю.';

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(text),
                  ));

                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
