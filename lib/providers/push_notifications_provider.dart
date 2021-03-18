import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_poc/components/message_notification.dart';
import 'package:overlay_support/overlay_support.dart';

class PushNotificationsProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messageStreamController = StreamController<String>.broadcast();

  Stream<String> get message => _messageStreamController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print("====== Firebase Token ======");
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (message) async {
        print(message);

        String argumento = "no-data";
        if (Platform.isAndroid) {
          argumento = message['data']['title'] ?? "no-data";
          _messageStreamController.sink.add(argumento);
          showOverlayNotification((context) {
            return MessageNotification(
                title: "Test",
                subtitle: argumento,
                onReplay: () {
                  OverlaySupportEntry.of(context).dismiss();
                });
          });
        }
        return;
      },
      onLaunch: (message) async {
        print(message);
        return;
      },
      onResume: (message) async {
        print(message);
        return;
      },
    );
  }

  dispose() {
    _messageStreamController?.close();
  }
}
