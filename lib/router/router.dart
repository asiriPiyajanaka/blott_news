import 'package:blott_news/features/news_dashboard/presentation/screens/news_dashboard_screen.dart';
import 'package:blott_news/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:blott_news/features/onboarding/presentation/screens/user_onboarding_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: UserOnboardingScreen.routeName,
  routes: [
    GoRoute(
      path: UserOnboardingScreen.routeName,
      name: UserOnboardingScreen.routeName,
      builder: (context, state) => const UserOnboardingScreen(),
    ),
    GoRoute(
      path: NotificationsScreen.routeName,
      name: NotificationsScreen.routeName,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: NewsDashboardScreen.routeName,
      name: NewsDashboardScreen.routeName,
      builder: (context, state) => const NewsDashboardScreen(),
    ),
  ],
  observers: [
    routeObserver,
  ],
  debugLogDiagnostics: true,
);

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
