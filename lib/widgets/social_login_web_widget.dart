import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:volunteer/main.dart';
import 'package:volunteer/models/social_media_type.dart';
import 'package:volunteer/screens/login_screen.dart';
import 'package:volunteer/widgets/link_account_login_widget.dart';

class SocialLoginWebWidget extends StatelessWidget {
  final OnSignedIn? onSignedIn;
  final List<SocialMediaType> socialMediaTypes;

  SocialLoginWebWidget(
      {List<SocialMediaType>? socialMediaTypes, this.onSignedIn})
      : this.socialMediaTypes = socialMediaTypes ??
            [
              SocialMediaType.GOOGLE,
              SocialMediaType.FACEBOOK,
              SocialMediaType.APPLE
            ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (socialMediaTypes.contains(SocialMediaType.GOOGLE))
          SignInButton(Buttons.Google, text: 'Увійти з Google',
              onPressed: () async {
            var credentials = await _signInWithGoogle(context);
            onSignedIn?.call(credentials);
          }),
        if (socialMediaTypes.contains(SocialMediaType.FACEBOOK))
          SignInButton(Buttons.FacebookNew, text: 'Увійти з Facebook',
              onPressed: () async {
            var credentials = await _signInWithFacebook(context);
            onSignedIn?.call(credentials);
          }),
      ],
    );
  }

  Future<UserCredential?> _signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    ) as GoogleAuthCredential;

    // Once signed in, return the UserCredential
    return _signInWith(credential, context);
  }

  Future<UserCredential?> _signInWithFacebook(BuildContext context) async {
    // For web and desktop the flow is different
    if (isWebOrDesktop) {
      // Create a new provider
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();

      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
      });

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(facebookProvider);
    }

    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token)
            as FacebookAuthCredential;

    return _signInWith(credential, context);
  }

  Future<UserCredential?> _signInWith(
      OAuthCredential credential, BuildContext context) async {
    // Once signed in, return the UserCredential
    try {
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // The account already exists with a different credential
        String? email = e.email;
        AuthCredential? pendingCredential = e.credential;

        if (email == null || pendingCredential == null) {
          return Future.value(null);
        }

        // Fetch a list of what sign-in methods exist for the conflicting user
        List<String> userSignInMethods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        showModalBottomSheet(
            context: context,
            builder: (context) {
              return LinkAccountLoginWidget('Facebook',
                  email: email,
                  userSignInMethods: userSignInMethods,
                  pendingCredential: pendingCredential);
            });

        return Future.value(null);
      }
    }
  }
}
