import 'package:blott_news/features/notifications/domain/repositories/notification_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate a mock class for FirebaseMessaging
import 'notification_repository_test.mocks.dart';

@GenerateMocks([FirebaseMessaging])
class TestNotificationRepository implements NotificationRepository {
  final FirebaseMessaging _firebaseMessaging;

  TestNotificationRepository(this._firebaseMessaging);

  @override
  Future<NotificationSettings> requestNotificationPermissions() {
    return _firebaseMessaging.requestPermission();
  }

  @override
  Future<String?> getNotificationToken() {
    return _firebaseMessaging.getToken();
  }
}

void main() {
  late MockFirebaseMessaging mockFirebaseMessaging;
  late NotificationRepository repository;

  setUp(() {
    mockFirebaseMessaging = MockFirebaseMessaging();
    repository = TestNotificationRepository(mockFirebaseMessaging);
  });

  group('NotificationRepository Tests', () {
    test('requestNotificationPermissions returns correct NotificationSettings',
        () async {
      // Arrange
      const mockSettings = NotificationSettings(
        alert: AppleNotificationSetting.enabled,
        announcement: AppleNotificationSetting.disabled,
        authorizationStatus: AuthorizationStatus.authorized,
        badge: AppleNotificationSetting.enabled,
        carPlay: AppleNotificationSetting.disabled,
        lockScreen: AppleNotificationSetting.enabled,
        notificationCenter: AppleNotificationSetting.enabled,
        showPreviews: AppleShowPreviewSetting.always,
        timeSensitive: AppleNotificationSetting.enabled,
        criticalAlert: AppleNotificationSetting.disabled,
        sound: AppleNotificationSetting.enabled,
      );
      when(mockFirebaseMessaging.requestPermission())
          .thenAnswer((_) async => mockSettings);

      // Act
      final result = await repository.requestNotificationPermissions();

      // Assert
      expect(result, equals(mockSettings));
      verify(mockFirebaseMessaging.requestPermission()).called(1);
    });

    test('getNotificationToken returns the correct token', () async {
      // Arrange
      const mockToken = 'mock_fcm_token';
      when(mockFirebaseMessaging.getToken()).thenAnswer((_) async => mockToken);

      // Act
      final result = await repository.getNotificationToken();

      // Assert
      expect(result, equals(mockToken));
      verify(mockFirebaseMessaging.getToken()).called(1);
    });

    test(
        'getNotificationToken returns null if FirebaseMessaging.getToken is null',
        () async {
      // Arrange
      when(mockFirebaseMessaging.getToken()).thenAnswer((_) async => null);

      // Act
      final result = await repository.getNotificationToken();

      // Assert
      expect(result, isNull);
      verify(mockFirebaseMessaging.getToken()).called(1);
    });
  });
}
