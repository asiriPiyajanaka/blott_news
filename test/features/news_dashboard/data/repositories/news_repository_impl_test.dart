import 'package:blott_news/features/news_dashboard/data/models/news_model.dart';
import 'package:blott_news/features/news_dashboard/data/repositories/news_repository_impl.dart';
import 'package:blott_news/features/news_dashboard/data/sources/news_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate a mock class for NewsApiService
import 'news_repository_impl_test.mocks.dart';

@GenerateMocks([NewsApiService])
void main() {
  late MockNewsApiService mockApiService;
  late NewsRepositoryImpl repository;

  setUp(() {
    mockApiService = MockNewsApiService();
    repository = NewsRepositoryImpl(mockApiService);
  });

  group('NewsRepositoryImpl Tests', () {
    test('getNews calls fetchNews and returns a list of NewsModel', () async {
      // Arrange
      const category = 'general';
      const token = 'test_token';
      const minId = 1;

      final mockApiResponse = [
        {
          'id': 1,
          'headline': 'Breaking News 1',
          'image': 'https://example.com/image1.jpg',
          'source': 'Source 1',
          'datetime': 1699999999, // Unix timestamp in seconds
          'summary': 'Summary of news 1',
          'url': 'https://example.com/news1',
        },
        {
          'id': 2,
          'headline': 'Breaking News 2',
          'image': 'https://example.com/image2.jpg',
          'source': 'Source 2',
          'datetime': 1699999998, // Unix timestamp in seconds
          'summary': 'Summary of news 2',
          'url': 'https://example.com/news2',
        },
      ];

      final expectedNewsList = [
        NewsModel(
          id: 1,
          headline: 'Breaking News 1',
          imageUrl: 'https://example.com/image1.jpg',
          source: 'Source 1',
          date: DateTime.fromMillisecondsSinceEpoch(1699999999 * 1000),
          summary: 'Summary of news 1',
          url: 'https://example.com/news1',
        ),
        NewsModel(
          id: 2,
          headline: 'Breaking News 2',
          imageUrl: 'https://example.com/image2.jpg',
          source: 'Source 2',
          date: DateTime.fromMillisecondsSinceEpoch(1699999998 * 1000),
          summary: 'Summary of news 2',
          url: 'https://example.com/news2',
        ),
      ];

      when(mockApiService.fetchNews(
        category: category,
        token: token,
        minId: minId,
      )).thenAnswer((_) async => mockApiResponse);

      // Act
      final result = await repository.getNews(
        category: category,
        token: token,
        minId: minId,
      );

      // Assert
      expect(result, equals(expectedNewsList));
      verify(mockApiService.fetchNews(
        category: category,
        token: token,
        minId: minId,
      )).called(1);
    });
  });
}
