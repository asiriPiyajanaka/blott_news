import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:blott_news/core/presentation/widgets/button.dart';
import 'package:blott_news/core/presentation/themes/app_colors.dart';
import 'package:blott_news/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:blott_news/features/notifications/data/sources/firebase_notification_service.dart';
import 'package:blott_news/features/notifications/domain/usecases/manage_notifications_usecase.dart';
import 'package:blott_news/features/notifications/presentation/controllers/notification_controller.dart';

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
                    SvgPicture.asset(
                      "assets/graphics/message_notif.svg",
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 26.0),
                const Text(
                  "Get the most out of Blott ✅",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: const Text(
                    "Allow notifications to stay in the loop with your payments, requests and groups.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onPressed: () => _controller.initializeNotifications(),
                  text: "Continue",
                  backgroundColor: AppColors.primary,
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
