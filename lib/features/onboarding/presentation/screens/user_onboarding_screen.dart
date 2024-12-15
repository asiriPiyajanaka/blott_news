import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserOnboardingScreen extends ConsumerStatefulWidget {
  const UserOnboardingScreen({super.key});

  static const routeName = '/user-onboarding-screen';

  @override
  ConsumerState<UserOnboardingScreen> createState() =>
      _UserOnboardingScreenState();
}

class _UserOnboardingScreenState extends ConsumerState<UserOnboardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
