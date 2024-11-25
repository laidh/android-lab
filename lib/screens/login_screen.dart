import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/screens/registration_screen.dart';
import 'package:volunteer/widgets/email_login_widget.dart';
import 'package:volunteer/widgets/social_login_widget.dart';
import 'package:volunteer/widgets/social_login_web_widget.dart';

typedef OnSignedIn = Function(UserCredential? userCredential);

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                ),
                SizedBox(
                  height: 32.0,
                ),
                EmailLoginWidget(),
                SizedBox(
                  height: 16.0,
                ),
                Text('- АБО -'),
                SizedBox(
                  height: 16.0,
                ),
                // Sign in with apple does not work on web
                if (kIsWeb) SocialLoginWebWidget() else SocialLoginWidget(),
                SizedBox(
                  height: 32.0,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Ще не маєте аккаунту? ',
                          style: TextStyle(
                              color: Colors.blueGrey, fontSize: 16.0)),
                      TextSpan(
                          text: 'Зареєструватись',
                          style: TextStyle(color: Colors.blue, fontSize: 16.0),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            })
                    ])),
              ],
            ),
          )),
    );
  }
}
