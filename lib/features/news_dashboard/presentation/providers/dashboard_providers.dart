import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blott_news/core/data/network/dio_client.dart.dart';
import 'package:blott_news/features/news_dashboard/data/repositories/news_repository_impl.dart';
import 'package:blott_news/features/news_dashboard/data/sources/news_api_service.dart';
import 'package:blott_news/features/news_dashboard/domain/usecases/fetch_news_usecase.dart';
import 'package:blott_news/features/news_dashboard/presentation/controllers/dashboard_controller.dart';

final dioClientProvider =
    Provider((ref) => DioClient("https://finnhub.io/api/v1"));

// News API service provider
final newsApiServiceProvider =
    Provider((ref) => NewsApiService(ref.read(dioClientProvider)));

// News repository provider
final newsRepositoryProvider =
    Provider((ref) => NewsRepositoryImpl(ref.read(newsApiServiceProvider)));

// Fetch news use case provider
final fetchNewsUseCaseProvider =
    Provider((ref) => FetchNewsUseCase(ref.read(newsRepositoryProvider)));

// Dashboard controller provider
final dashboardControllerProvider = ChangeNotifierProvider(
    (ref) => DashboardController(ref.read(fetchNewsUseCaseProvider)));
