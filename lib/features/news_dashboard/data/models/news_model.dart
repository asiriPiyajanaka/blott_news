import 'package:blott_news/features/news_dashboard/domain/entities/news_entity.dart';

class NewsModel extends NewsEntity {
  const NewsModel({
    required super.id,
    required super.headline,
    required super.imageUrl,
    required super.source,
    required super.date,
    required super.summary,
    required super.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as int,
      headline: json['headline'] as String,
      imageUrl: json['image'] as String,
      source: json['source'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(json['datetime'] * 1000),
      summary: json['summary'] as String,
      url: json['url'] as String,
    );
  }
}
