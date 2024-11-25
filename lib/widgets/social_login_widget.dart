import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:volunteer/main.dart';
import 'package:volunteer/models/social_media_type.dart';
import 'package:volunteer/screens/login_screen.dart';
import 'package:volunteer/widgets/link_account_login_widget.dart';

class SocialLoginWidget extends StatelessWidget {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");
  final OnSignedIn? onSignedIn;
  final List<SocialMediaType> socialMediaTypes;

  SocialLoginWidget({List<SocialMediaType>? socialMediaTypes, this.onSignedIn})
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
        if (socialMediaTypes.contains(SocialMediaType.APPLE) &&
            (Platform.isIOS || Platform.isMacOS))
          SignInButton(Buttons.AppleDark, text: 'Увійти з Apple',
              onPressed: () async {
            var credentials = await _signInWithApple(context);
            onSignedIn?.call(credentials);
          })
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

  Future<UserCredential?> _signInWithApple(BuildContext context) async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    if (isWebOrDesktop) {
      // Create and configure an OAuthProvider for Sign In with Apple.
      final credential = OAuthProvider("apple.com")
        ..addScope('email')
        ..addScope('name');

      // Sign in the user with Firebase.
      return await FirebaseAuth.instance.signInWithPopup(credential);
    } else {
      // Create an `OAuthCredential` from the credential returned by Apple.
      final credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      return _signInWith(credential, context);
    }
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

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String _generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
