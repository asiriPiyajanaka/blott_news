# blott_news

A Flutter project designed for dynamic news delivery and customization.

Features
• Light and Dark Theme Support using Riverpod for state management.
• Theme persistence using SharedPreferences.
• Routing with MaterialApp.router for clean and declarative navigation.
• Clean and modular structure with components like ThemeNotifier.

Environment Setup

To run this project, you need to create an .env file in the root directory of the Flutter application. The .env file should include all the necessary environment variables for API keys and other configurations.

Technologies Used

Core Frameworks and Tools
• Flutter: The main framework for building cross-platform applications.
• Dart: The programming language used with Flutter.

State Management
• Riverpod: For efficient and reactive state management.

Storage
• SharedPreferences: To persist user preferences such as theme mode.

Routing
• MaterialApp.router: For declarative and efficient navigation.

Testing
• flutter_test: For writing widget tests.
• ProviderScope in Tests: Ensuring compatibility with Riverpod during testing.

Theming
• Dynamic Theming: Light and dark themes with ThemeMode switching.
• Custom MaterialColor: Created from base colors to comply with primarySwatch.
