import 'package:blott_news/features/notifications/domain/repositories/notification_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ManageNotificationsUseCase {
  final NotificationRepository _repository;

  ManageNotificationsUseCase(this._repository);

  Future<NotificationSettings> requestPermissions() {
    return _repository.requestNotificationPermissions();
  }

  Future<String?> retrieveFCMToken() {
    return _repository.getNotificationToken();
  }
}
