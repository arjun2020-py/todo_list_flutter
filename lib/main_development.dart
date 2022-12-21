// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/app.dart';
import 'package:todo/bootstrap.dart';

//1 firebase messaging
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.messageId);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

//2
  await FirebaseMessaging.instance
      .requestPermission(alert: true, sound: true, badge: true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  bootstrap(() => const App());
}
