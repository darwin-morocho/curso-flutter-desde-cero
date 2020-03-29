import 'package:meta/meta.dart' show required;

class YVideo {
  final String id, title, description, thumbnail;
  final DateTime publishedAt;

  YVideo(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.thumbnail,
      @required this.publishedAt});

  factory YVideo.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'];

    final thumbnail =
        snippet['thumbnails']['standard'] ?? snippet['thumbnails']['high'];

    return YVideo(
        id: json['contentDetails']['upload']['videoId'],
        title: snippet['title'],
        description: snippet['description'],
        thumbnail: thumbnail['url'],
        publishedAt: DateTime.parse(snippet['publishedAt']));
  }
}
