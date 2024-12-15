import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsDashboardScreen extends ConsumerStatefulWidget {
  const NewsDashboardScreen({super.key});

  static const routeName = '/news_dashboard_screen';

  @override
  ConsumerState<NewsDashboardScreen> createState() =>
      _NewsDashboardScreenState();
}

class _NewsDashboardScreenState extends ConsumerState<NewsDashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
