class NewsEntity {
  final int id;
  final String headline;
  final String imageUrl;
  final String source;
  final DateTime date;
  final String summary;
  final String url;

  const NewsEntity({
    required this.id,
    required this.headline,
    required this.imageUrl,
    required this.source,
    required this.date,
    required this.summary,
    required this.url,
  });
}
