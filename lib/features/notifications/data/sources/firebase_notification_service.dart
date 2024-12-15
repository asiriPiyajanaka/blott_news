import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _messaging;

  FirebaseNotificationService() : _messaging = FirebaseMessaging.instance;

  Future<NotificationSettings> requestPermission() {
    return _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<String?> getToken() {
    return _messaging.getToken();
  }
}
