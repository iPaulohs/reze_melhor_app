import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void notificationTapBackground(NotificationResponse details) {
  if (details.payload != null) {
    Logger().i("Background Notification Tapped: ${details.payload}");
  }
}

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String title;
  final String? body;
  final String? payload;
}

class NotificationsService {
  NotificationsService() {
    notificationsPlugin = FlutterLocalNotificationsPlugin();
    androidNotificationDetails = AndroidNotificationDetails(
      "notifications_service",
      "notifications",
      importance: Importance.max,
      enableVibration: true,
    );
    setupNotifications();
  }

  late FlutterLocalNotificationsPlugin notificationsPlugin;
  late AndroidNotificationDetails androidNotificationDetails;

  void setupNotifications() async {
    await requestPermissions();
    await setupTimeZone();
    await initializeNotifications();
  }

  Future<void> setupTimeZone() async {
    tz.initializeTimeZones();
    final localName = tz.local.name;
    tz.setLocalLocation(tz.getLocation(localName));
  }

  Future<void> initializeNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    await notificationsPlugin.initialize(
      InitializationSettings(android: androidSettings),
      
      // Função global para eventos em segundo plano
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,

      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          Logger().i("Foreground Notification Tapped: ${details.payload}");
        }
      },
    );
  }

  Future<void> requestPermissions() async {
    if (await Permission.notification.isGranted) {
      return;
    }

    final androidImplementation = notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      await androidImplementation.requestNotificationsPermission();
    }
  }

  void showNotification(NotificationModel model) {
    notificationsPlugin.show(
      model.id,
      model.title,
      model.body,
      NotificationDetails(android: androidNotificationDetails),
      payload: model.payload,
    );
  }
}
