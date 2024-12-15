import 'package:blott_news/core/data/network/dio_client.dart.dart';

class NewsApiService {
  final DioClient dioClient;

  NewsApiService(this.dioClient);

  Future<List<dynamic>> fetchNews({
    required String category,
    required String token,
    required int minId,
  }) async {
    final response = await dioClient.get(
      '/news',
      queryParameters: {
        'category': category,
        'token': token,
        'minId': minId,
      },
    );
    return response.data as List<dynamic>;
  }
}
