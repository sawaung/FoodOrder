import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ooredoo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});

    // Request Permissions
    await _requestPermissions();        
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

   Future<void> _requestPermissions() async {
    // Request permissions for Android 13+
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // Request permissions for iOS
    if (await notificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
        false) {
      debugPrint("Notification permissions granted for iOS");
    } else {
      debugPrint("Notification permissions denied for iOS");
    }
  }

    Future<void> checkNotificationPermissionStatus() async {
    var status = await Permission.notification.status;

    if (status.isGranted) {
      debugPrint("Notification permissions are granted.");
    } else if (status.isDenied) {
      debugPrint("Notification permissions are denied. Requesting now...");
      await Permission.notification.request();
    } else if (status.isPermanentlyDenied) {
      debugPrint("Notification permissions are permanently denied. Open settings.");
      openAppSettings();
    }
  }
}