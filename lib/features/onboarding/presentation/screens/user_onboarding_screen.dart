import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:blott_news/core/presentation/themes/app_colors.dart';
import 'package:blott_news/core/presentation/themes/theme_notifier.dart';
import 'package:blott_news/features/onboarding/presentation/controllers/user_onboarding_controller.dart';
import 'package:blott_news/features/onboarding/presentation/widgets/header_section.dart';

class UserOnboardingScreen extends ConsumerStatefulWidget {
  const UserOnboardingScreen({super.key});

  static const routeName = '/user-onboarding-screen';

  @override
  ConsumerState<UserOnboardingScreen> createState() =>
      _UserOnboardingScreenState();
}

class _UserOnboardingScreenState extends ConsumerState<UserOnboardingScreen> {
  late final UserOnboardingController _controller;

  @override
  void initState() {
    super.initState();

    // Ensure the app is always in light mode when this screen loads
    Future.microtask(() {
      ref.read(themeNotifierProvider.notifier).setLightTheme();
    });

    _controller = UserOnboardingController(
      context: context,
      onSubmitSuccess: () => context.go('/notifications-screen'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(),
              const SizedBox(height: 32.0),
              TextField(
                controller: _controller.firstNameController,
                decoration: const InputDecoration(
                  hintText: 'First name',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _controller.lastNameController,
                decoration: const InputDecoration(
                  hintText: 'Last name',
                  border: UnderlineInputBorder(),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _controller.isButtonEnabled,
                  builder: (_, isEnabled, __) {
                    return FloatingActionButton(
                      onPressed: isEnabled ? _controller.onSubmit : null,
                      backgroundColor: isEnabled
                          ? AppColors.primary
                          : Color.alphaBlend(
                              Colors.white.withOpacity(0.6), AppColors.primary),
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
