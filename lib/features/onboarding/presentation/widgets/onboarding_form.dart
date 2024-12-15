import 'package:blott_news/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingForm extends ConsumerStatefulWidget {
  const OnboardingForm({super.key});

  @override
  ConsumerState<OnboardingForm> createState() => _OnboardingFormState();
}

class _OnboardingFormState extends ConsumerState<OnboardingForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_validateForm);
    _lastNameController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isFormValid = _firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty;

    if (isFormValid != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isFormValid;
      });
    }
  }

  void _onSubmit() {
    // Handle form submission logic
    context.go('/notification-screens');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'First name',
            border: UnderlineInputBorder(),
          ),
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last name',
            border: UnderlineInputBorder(),
          ),
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 32.0),
        const Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            onPressed: _isButtonEnabled ? _onSubmit : null,
            backgroundColor: _isButtonEnabled
                ? AppColors.primary
                : Color.alphaBlend(
                    Colors.white.withOpacity(0.6), AppColors.primary),
            child: const Icon(Icons.arrow_forward),
          ),
        ),
      ],
    );
  }
}
