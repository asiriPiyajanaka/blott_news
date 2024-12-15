import 'package:blott_news/core/utils/shared_preferences_manager.dart';
import 'package:blott_news/features/onboarding/data/repositories/user_repository_impl.dart';
import 'package:blott_news/features/onboarding/domain/models/user_model.dart';
import 'package:blott_news/features/onboarding/domain/usecases/submit_user_data_usecase.dart';
import 'package:flutter/material.dart';

class UserOnboardingController {
  final BuildContext context;
  final VoidCallback onSubmitSuccess;

  late final SubmitUserDataUseCase _submitUserDataUseCase;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);
  final SharedPreferencesManager _prefsManager = SharedPreferencesManager();

  UserOnboardingController({
    required this.context,
    required this.onSubmitSuccess,
  }) {
    _submitUserDataUseCase = SubmitUserDataUseCase(UserRepositoryImpl());
    firstNameController.addListener(_updateButtonState);
    lastNameController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final isEnabled = firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty;
    if (isButtonEnabled.value != isEnabled) {
      isButtonEnabled.value = isEnabled;
    }
  }

  Future<void> _saveToLocalStorage(String firstName, String lastName) async {
    await _prefsManager.saveString('firstName', firstName);
    await _prefsManager.saveString('lastName', lastName);
  }

  void onSubmit() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();

    final validationError =
        _submitUserDataUseCase.validateInput(firstName, lastName);
    if (validationError != null) {
      // Ensure using the correct BuildContext
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationError)),
      );
      return;
    }

    final user = UserModel(firstName: firstName, lastName: lastName);
    try {
      await _submitUserDataUseCase.call(user);
      await _saveToLocalStorage(firstName, lastName);
      onSubmitSuccess();
    } catch (e) {
      // Ensure using the correct BuildContext
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    isButtonEnabled.dispose();
  }
}
