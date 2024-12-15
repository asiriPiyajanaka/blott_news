import 'package:blott_news/features/onboarding/domain/models/user_model.dart';
import 'package:blott_news/features/onboarding/domain/repositories/user_repository.dart';
import 'package:blott_news/features/onboarding/domain/usecases/submit_user_data_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate a mock class for UserRepository
import 'submit_user_data_usecase_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockRepository;
  late SubmitUserDataUseCase useCase;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = SubmitUserDataUseCase(mockRepository);
  });

  group('SubmitUserDataUseCase - validateInput', () {
    test('returns null for valid input', () {
      // Arrange
      const firstName = 'John';
      const lastName = 'Doe';

      // Act
      final result = useCase.validateInput(firstName, lastName);

      // Assert
      expect(result, isNull);
    });

    test('returns error message for empty firstName', () {
      // Arrange
      const firstName = '';
      const lastName = 'Doe';

      // Act
      final result = useCase.validateInput(firstName, lastName);

      // Assert
      expect(result, 'Please fill in both fields.');
    });

    test('returns error message for empty lastName', () {
      // Arrange
      const firstName = 'John';
      const lastName = '';

      // Act
      final result = useCase.validateInput(firstName, lastName);

      // Assert
      expect(result, 'Please fill in both fields.');
    });

    test('returns error message for both fields empty', () {
      // Arrange
      const firstName = '';
      const lastName = '';

      // Act
      final result = useCase.validateInput(firstName, lastName);

      // Assert
      expect(result, 'Please fill in both fields.');
    });
  });

  group('SubmitUserDataUseCase - call', () {
    test('calls submitUserData on repository with valid UserModel', () async {
      // Arrange
      final user = UserModel(firstName: 'John', lastName: 'Doe');
      when(mockRepository.submitUserData(user))
          .thenAnswer((_) async => Future.value());

      // Act
      await useCase.call(user);

      // Assert
      verify(mockRepository.submitUserData(user)).called(1);
    });
  });
}
