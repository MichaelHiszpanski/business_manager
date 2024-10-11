import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //static const platform = MethodChannel('flutter_local_notifications');

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'To-Do Notifications',
      importance: Importance.max,
      priority: Priority.high,
      color: const Color(0xFF4CAF50),
      ledColor: const Color(0x141CAF50),
      ledOnMs: 1000,
      ledOffMs: 500,
      playSound: true,
      enableLights: true,
      enableVibration: true,
      showProgress: true,
      styleInformation: BigTextStyleInformation(
        body,
        contentTitle: title,
        htmlFormatContent: true,
        htmlFormatTitle: true,
      ),
      icon: '@mipmap/ic_launcher',
      colorized: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails);
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
