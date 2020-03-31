import 'package:meta/meta.dart' show required;

class YouTubeVideo {
  final String videoId, title, description, banner;

  YouTubeVideo(
      {@required this.videoId,
      @required this.title,
      @required this.description,
      @required this.banner});

  factory YouTubeVideo.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'];
    final thumbnail =
        snippet['thumbnails']['standard'] ?? snippet['thumbnails']['high'];

    return YouTubeVideo(
        videoId: json['contentDetails']['upload']['videoId'],
        title: snippet['title'],
        description: snippet['description'],
        banner: thumbnail['url']);
  }
}
