import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsManager {
  static init(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Message data: ${message.data}');

      RemoteNotification? notification = message.notification;

      if (notification != null) {
        log('Message notification: $notification');

        if (message.data['type'] == 'new-poll') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Нове опитування'),
                  content: Text('${notification.body}'),
                  actions: [
                    TextButton(
                      child: Text('Пізніше',
                          style: TextStyle(color: Colors.blueGrey)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text('Перейти'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        }
      }
    });
  }
}
