import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/router.dart';
import 'core/presentation/themes/light_theme.dart';
import 'core/presentation/themes/dark_theme.dart';
import 'core/presentation/themes/theme_notifier.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider); // Watch theme state

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Blott News',
      theme: lightTheme, // Light Theme
      darkTheme: darkTheme, // Dark Theme
      themeMode: themeMode, // Dynamically switch between light and dark
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
