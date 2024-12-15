import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationRepository {
  Future<NotificationSettings> requestNotificationPermissions();
  Future<String?> getNotificationToken();
}
