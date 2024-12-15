import 'package:blott_news/features/notifications/domain/repositories/notification_repository.dart';
import 'package:blott_news/features/notifications/domain/usecases/manage_notifications_usecase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate a mock class for NotificationRepository
import 'manage_notifications_usecase_test.mocks.dart';

@GenerateMocks([NotificationRepository])
void main() {
  late MockNotificationRepository mockRepository;
  late ManageNotificationsUseCase useCase;

  setUp(() {
    mockRepository = MockNotificationRepository();
    useCase = ManageNotificationsUseCase(mockRepository);
  });

  group('ManageNotificationsUseCase Tests', () {
    test(
        'requestPermissions calls requestNotificationPermissions on repository',
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

      when(mockRepository.requestNotificationPermissions())
          .thenAnswer((_) async => mockSettings);

      // Act
      final result = await useCase.requestPermissions();

      // Assert
      expect(result, equals(mockSettings));
      verify(mockRepository.requestNotificationPermissions()).called(1);
    });

    test('retrieveFCMToken calls getNotificationToken on repository', () async {
      // Arrange
      const mockToken = 'mock_fcm_token';
      when(mockRepository.getNotificationToken())
          .thenAnswer((_) async => mockToken);

      // Act
      final result = await useCase.retrieveFCMToken();

      // Assert
      expect(result, equals(mockToken));
      verify(mockRepository.getNotificationToken()).called(1);
    });

    test('retrieveFCMToken returns null if repository returns null', () async {
      // Arrange
      when(mockRepository.getNotificationToken()).thenAnswer((_) async => null);

      // Act
      final result = await useCase.retrieveFCMToken();

      // Assert
      expect(result, isNull);
      verify(mockRepository.getNotificationToken()).called(1);
    });
  });
}
