import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 通知に関する設定を取得する
  //
  // この記述があるとアプリの起動時に「...は通知を送信します。よろしいですか？」というダイアログが表示される
  // provisional: trueが設定されている場合、初回の通知を受信してから通知を許可するか決めることができる
  final notificationSettings =
      await FirebaseMessaging.instance.requestPermission();

  // FCMトークンを取得する
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCMトークン: $fcmToken');

  // アプリがフォアグラウンドになっている状態でプッシュ通知を受信した時のハンドラ
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('notification received in foreground');
    print('title: ${message.notification?.title}');
    print('body: ${message.notification?.body}');
  });

  runApp(const App());
}
