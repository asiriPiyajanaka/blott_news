import 'package:flutter/material.dart';
import 'package:blott_news/features/news_dashboard/domain/entities/news_entity.dart';
import 'package:blott_news/features/news_dashboard/domain/usecases/fetch_news_usecase.dart';

class DashboardController with ChangeNotifier {
  final FetchNewsUseCase fetchNewsUseCase;

  List<NewsEntity> newsList = [];
  bool isLoading = false;
  bool isFetchingMore = false;
  bool hasMoreData = true;
  int minId = 0;
  String? error;

  DashboardController(this.fetchNewsUseCase);

  Future<void> loadNews(
      {required String category, required String token}) async {
    if (isLoading) return;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final newNews = await fetchNewsUseCase(
        category: category,
        token: token,
        minId: 0,
      );
      newsList = newNews;
      hasMoreData = newNews.length >= 10; // Check if there are more data
    } catch (e) {
      error = 'Failed to load news. Please try again later.';
      debugPrint('Error loading news: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreNews(
      {required String category, required String token}) async {
    if (isFetchingMore || !hasMoreData) return;

    isFetchingMore = true;
    error = null; // Clear previous errors
    notifyListeners();

    try {
      final newNews = await fetchNewsUseCase(
        category: category,
        token: token,
        minId: newsList.isNotEmpty ? newsList.last.id : 0,
      );
      if (newNews.isEmpty || newNews.length < 10) {
        hasMoreData = false;
      }
      newsList.addAll(newNews);
    } catch (e) {
      error = 'Failed to load more news. Please try again later.';
      debugPrint('Error loading more news: $e');
    } finally {
      isFetchingMore = false;
      notifyListeners();
    }
  }
}
