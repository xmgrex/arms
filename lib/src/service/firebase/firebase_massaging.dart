import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class NotificationService {
  final messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await messaging.getToken().then((value) {
      logger.config('token: ${value!} :');
    });
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      logger.info('User granted permission');

      FirebaseMessaging.onMessage.listen((message) {
        logger.info('Got a message whilst in the foreground!');
        logger.info('Message data: ${message.data}');

        final notification = message.notification;
        final android = message.notification?.android;

        if (notification != null) {
          logger.info('Message also contained a notification: ${message.notification.toString()}');

          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                ),
              ));
        }
      });
    }
  }
  
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  void backgroundMessaging() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

}

final notificationServiceProvider = Provider((ref) => NotificationService());
