import 'package:blott_news/features/onboarding/domain/models/user_model.dart';
import 'package:blott_news/features/onboarding/domain/repositories/user_repository.dart';

class SubmitUserDataUseCase {
  final UserRepository repository;

  SubmitUserDataUseCase(this.repository);

  String? validateInput(String firstName, String lastName) {
    if (firstName.isEmpty || lastName.isEmpty) {
      return 'Please fill in both fields.';
    }
    return null;
  }

  Future<void> call(UserModel user) async {
    await repository.submitUserData(user);
  }
}
