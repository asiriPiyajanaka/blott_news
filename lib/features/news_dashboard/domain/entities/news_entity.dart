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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsEntity &&
        other.id == id &&
        other.headline == headline &&
        other.imageUrl == imageUrl &&
        other.source == source &&
        other.date == date &&
        other.summary == summary &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        headline.hashCode ^
        imageUrl.hashCode ^
        source.hashCode ^
        date.hashCode ^
        summary.hashCode ^
        url.hashCode;
  }
}
