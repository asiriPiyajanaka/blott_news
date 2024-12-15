import 'package:blott_news/features/news_dashboard/domain/entities/news_entity.dart';
import 'package:blott_news/features/news_dashboard/domain/repositories/news_repository.dart';
import 'package:blott_news/features/news_dashboard/domain/usecases/fetch_news_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate a mock class for NewsRepository
import 'fetch_news_usecase_test.mocks.dart';

@GenerateMocks([NewsRepository])
void main() {
  late MockNewsRepository mockRepository;
  late FetchNewsUseCase useCase;

  setUp(() {
    mockRepository = MockNewsRepository();
    useCase = FetchNewsUseCase(mockRepository);
  });

  group('FetchNewsUseCase Tests', () {
    test('calls getNews on the repository with correct parameters', () async {
      // Arrange
      const category = 'general';
      const token = 'test_token';
      const minId = 1;

      final mockNewsList = [
        NewsEntity(
          id: 1,
          headline: 'Breaking News 1',
          imageUrl: 'https://example.com/image1.jpg',
          source: 'Source 1',
          date: DateTime.now(),
          summary: 'Summary of news 1',
          url: 'https://example.com/news1',
        ),
        NewsEntity(
          id: 2,
          headline: 'Breaking News 2',
          imageUrl: 'https://example.com/image2.jpg',
          source: 'Source 2',
          date: DateTime.now(),
          summary: 'Summary of news 2',
          url: 'https://example.com/news2',
        ),
      ];

      when(mockRepository.getNews(
        category: category,
        token: token,
        minId: minId,
      )).thenAnswer((_) async => mockNewsList);

      // Act
      final result = await useCase.call(
        category: category,
        token: token,
        minId: minId,
      );

      // Assert
      expect(result, equals(mockNewsList));
      verify(mockRepository.getNews(
        category: category,
        token: token,
        minId: minId,
      )).called(1);
    });

    test('returns an empty list if the repository returns no news', () async {
      // Arrange
      const category = 'general';
      const token = 'test_token';
      const minId = 1;

      when(mockRepository.getNews(
        category: category,
        token: token,
        minId: minId,
      )).thenAnswer((_) async => []);

      // Act
      final result = await useCase.call(
        category: category,
        token: token,
        minId: minId,
      );

      // Assert
      expect(result, isEmpty);
      verify(mockRepository.getNews(
        category: category,
        token: token,
        minId: minId,
      )).called(1);
    });
  });
}
