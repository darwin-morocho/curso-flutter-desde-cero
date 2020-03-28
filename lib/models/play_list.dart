import 'package:meta/meta.dart' show required;

class PlayList {
  final String id, title, description, thumbnail;
  final DateTime publishedAt;
  final int itemCount;

  PlayList(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.thumbnail,
      @required this.publishedAt,
      @required this.itemCount});

  factory PlayList.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'];

    final thumbnail =
        snippet['thumbnails']['standard'] ?? snippet['thumbnails']['high'];

    return PlayList(
        id: json['id'],
        title: snippet['title'],
        description: snippet['description'],
        thumbnail: thumbnail['url'],
        publishedAt: DateTime.parse(snippet['publishedAt']),
        itemCount: json['contentDetails']['itemCount']);
  }
}
