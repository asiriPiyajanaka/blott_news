import 'package:blott_news/features/notifications/data/sources/firebase_notification_service.dart';
import 'package:blott_news/features/notifications/domain/repositories/notification_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FirebaseNotificationService _service;

  NotificationRepositoryImpl(this._service);

  @override
  Future<NotificationSettings> requestNotificationPermissions() {
    return _service.requestPermission();
  }

  @override
  Future<String?> getNotificationToken() {
    return _service.getToken();
  }
}
