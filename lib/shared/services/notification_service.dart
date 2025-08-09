import 'dart:io';
import 'package:bubble_todo_list/core/utils/handle_conversion_tz_and_date_time.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin plugin;
  final String uid;

  NotificationService({required this.plugin, required this.uid});

  Future<void> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      await plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
    }
  }

  Future<void> showScheduleNotification({required DateTime utc, required String title}) async {
    await plugin.zonedSchedule(
      uid.hashCode, 
      title, 
      '快去完成吧！', 
      HandleConversionTzAndDateTime.utcToTzLocal(utc: utc),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          '0', 
          'schedule notification',
          importance: Importance.max,
          priority: Priority.max
        )
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification({required String uid}) async {
    await plugin.cancel(uid.hashCode);
  }
}