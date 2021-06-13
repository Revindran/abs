import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var locations;

  void main() {
    tz.initializeTimeZones();
    locations = tz.timeZoneDatabase.locations;
  }

  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("ic_launcher");

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future instantNofitication() async {
    var android = AndroidNotificationDetails("id", "channel", "description",
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    var ios = IOSNotificationDetails();

    var platform = new NotificationDetails(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo instant notification", "Tap to do something", platform,
        payload: "Welcome to demo app");
  }

  Future schedule90DaysNotification() {
    return _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        '90 Days Notification!',
        '90 Days Notification!',
        nextInstanceOf90Days(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'id',
            'name',
            'description',
            importance: Importance.max,
            priority: Priority.high,
            enableVibration: true,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime nextInstanceOf90Days() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 4, 30);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 90));
    }
    return scheduledDate;
  }

  Future schedule365DaysNotification() {
    return _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        '90 Days Notification!',
        '90 Days Notification!',
        nextInstanceOf365Days(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'id',
            'name',
            'description',
            importance: Importance.max,
            priority: Priority.high,
            enableVibration: true,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime nextInstanceOf365Days() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 4, 30);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 365));
    }
    return scheduledDate;
  }

  Future scheduleAlarmNotification(String message) {
    return _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        message == null ? "No Message" : message,
        'Your Scheduled message',
        nextInstanceOfAlarm(DateTime.now()),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'id',
            'name',
            'description',
            ongoing: true,
            importance: Importance.max,
            priority: Priority.high,
            enableVibration: true,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime nextInstanceOfAlarm(DateTime setDate) {
    final tz.TZDateTime now = tz.TZDateTime.now(locations.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        locations.local,
        setDate.year ?? now.year,
        setDate.month ?? now.month,
        setDate.day ?? now.day,
        setDate.hour ?? now.hour,
        setDate.minute ?? now.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future scheduleNo(scheduleTime, message) {
    return _flutterLocalNotificationsPlugin.schedule(
      1,
      message == null ? "No Message" : message,
      'Your Scheduled message',
      scheduleTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'id',
          'name',
          'description',
          ongoing: true,
          importance: Importance.max,
          priority: Priority.high,
          enableVibration: true,
        ),
      ),
    );
  }
}
