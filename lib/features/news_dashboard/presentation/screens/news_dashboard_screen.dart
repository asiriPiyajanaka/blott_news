import 'package:blott_news/core/utils/shared_preferences_manager.dart';
import 'package:blott_news/features/news_dashboard/presentation/providers/dashboard_providers.dart';
import 'package:blott_news/features/news_dashboard/presentation/widgets/error_widget.dart';
import 'package:blott_news/features/news_dashboard/presentation/widgets/news_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDashboardScreen extends ConsumerStatefulWidget {
  const NewsDashboardScreen({super.key});

  static const routeName = '/news-dashboard-screen';

  @override
  ConsumerState<NewsDashboardScreen> createState() =>
      _NewsDashboardScreenState();
}

class _NewsDashboardScreenState extends ConsumerState<NewsDashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  String? firstName;

  @override
  void initState() {
    super.initState();

    _loadFirstName();

    // Use Future.microtask to safely load data
    Future.microtask(() {
      ref.read(dashboardControllerProvider).loadNews(
            category: "general",
            token: dotenv.env['FINHUB_API_KEY']!,
          );
    });

    // Scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        ref.read(dashboardControllerProvider).loadMoreNews(
              category: "general",
              token: dotenv.env['FINHUB_API_KEY']!,
            );
      }
    });
  }

  Future<void> _loadFirstName() async {
    final prefsManager = SharedPreferencesManager();
    await prefsManager.init(); // Ensure SharedPreferences is initialized
    setState(() {
      firstName = prefsManager.getString('firstName') ?? 'Guest';
    });
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the link')),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(dashboardControllerProvider);

    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16.0, top: 50.0),
            child: Text(
              "Hey ${firstName ?? 'Guest'}",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.01,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : controller.error != null
                    ? CustomErrorWidget(
                        message: controller.error!,
                        onRetry: () {
                          ref.read(dashboardControllerProvider).loadNews(
                                category: "general",
                                token: dotenv.env['FINHUB_API_KEY']!,
                              );
                        },
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: controller.newsList.length + 1,
                        itemBuilder: (context, index) {
                          if (index == controller.newsList.length) {
                            if (controller.isFetchingMore) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            } else if (!controller.hasMoreData) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(child: Text("That's all!")),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }

                          final news = controller.newsList[index];
                          return NewsListItem(
                            news: news,
                            onTap: () async {
                              await _launchUrl(news.url, context);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
