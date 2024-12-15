import 'package:blott_news/features/news_dashboard/data/models/news_model.dart';
import 'package:blott_news/features/news_dashboard/data/sources/news_api_service.dart';
import 'package:blott_news/features/news_dashboard/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiService apiService;

  NewsRepositoryImpl(this.apiService);

  @override
  Future<List<NewsModel>> getNews({
    required String category,
    required String token,
    required int minId,
  }) async {
    final data = await apiService.fetchNews(
      category: category,
      token: token,
      minId: minId,
    );
    return data.map<NewsModel>((json) => NewsModel.fromJson(json)).toList();
  }
}
