import 'package:blott_news/features/news_dashboard/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<List<NewsEntity>> getNews({
    required String category,
    required String token,
    required int minId,
  });
}
