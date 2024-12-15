import 'package:blott_news/features/news_dashboard/domain/entities/news_entity.dart';
import 'package:blott_news/features/news_dashboard/domain/repositories/news_repository.dart';

class FetchNewsUseCase {
  final NewsRepository repository;

  FetchNewsUseCase(this.repository);

  Future<List<NewsEntity>> call({
    required String category,
    required String token,
    required int minId,
  }) {
    return repository.getNews(category: category, token: token, minId: minId);
  }
}
