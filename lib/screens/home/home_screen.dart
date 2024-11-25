import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/main.dart';
import 'package:volunteer/screens/home/home_desktop_screen.dart';
import 'package:volunteer/screens/home/home_mobile_screen.dart';

class HomeScreen extends StatelessWidget {
  // TODO: Update to properly show notifications when delivered:
  // see https://firebase.flutter.dev/docs/messaging/notifications#advanced-usage for more details

  final Future<NotificationSettings> futureSettings =
      FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NotificationSettings>(
      future: futureSettings,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        var settings = snapshot.data!;

        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          log('User granted notifications permission');
        } else if (settings.authorizationStatus ==
            AuthorizationStatus.provisional) {
          log('User granted notifications provisional permission');
        } else {
          log('User declined or has not accepted notifications permission');
        }

        if (isWebOrDesktop) {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                return HomeDesktopScreen();
              } else {
                return HomeMobileScreen();
              }
            },
          );
        } else {
          return HomeMobileScreen();
        }
      },
    );
  }
}
