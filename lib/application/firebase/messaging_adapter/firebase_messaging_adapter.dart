import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

//TODO: Criar a lógica para criar o usuário no backend

class FirebaseMessagingAdapter {
  final firebaseMessaging = FirebaseMessaging.instance;
  final logger = Logger();

  Future<void> requestPermissionsFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    logger.i(settings.authorizationStatus);
  }

  Future<String?> getToken() async => await firebaseMessaging.getToken();
}
