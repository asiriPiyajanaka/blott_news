import 'package:blott_news/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:blott_news/features/notifications/data/sources/firebase_notification_service.dart';
import 'package:blott_news/features/notifications/domain/usecases/manage_notifications_usecase.dart';
import 'package:blott_news/features/notifications/presentation/controllers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  static const routeName = '/notifications-screen';

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  late final NotificationController _controller;

  @override
  void initState() {
    super.initState();

    final service = FirebaseNotificationService();
    final repository = NotificationRepositoryImpl(service);
    final useCase = ManageNotificationsUseCase(repository);

    _controller = NotificationController(useCase, context, ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Icon(
                      Icons.chat_bubble,
                      size: 80.0,
                      color: Colors.grey.shade400,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Get the most out of Blott ✅",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Allow notifications to stay in the loop with your payments, requests and groups.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _controller.initializeNotifications(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
