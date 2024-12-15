import 'package:blott_news/core/presentation/themes/theme_notifier.dart';
import 'package:blott_news/features/notifications/domain/usecases/manage_notifications_usecase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationController {
  final ManageNotificationsUseCase _useCase;
  final BuildContext context;
  final WidgetRef ref; // Add WidgetRef to access providers

  NotificationController(this._useCase, this.context, this.ref);

  Future<void> initializeNotifications() async {
    final settings = await _useCase.requestPermissions();

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('Notification permission granted');
      _navigateToDashboard(); // Use common method for navigation
    } else {
      _showSnackBar('Please grant notification permission');
      debugPrint('Notification permission denied');
    }

    final token = await _useCase.retrieveFCMToken();
    debugPrint('FCM Token: $token');
  }

  void _navigateToDashboard() {
    // Set theme to dark before navigating
    ref.read(themeNotifierProvider.notifier).setDarkTheme();
    if (context.mounted) {
      context.go('/news-dashboard-screen');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
