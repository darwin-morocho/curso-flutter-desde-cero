import 'package:meta/meta.dart' show required;

class YouTubeVideo {
  final String videoId, title, description, banner;

  YouTubeVideo(
      {@required this.videoId,
      @required this.title,
      @required this.description,
      @required this.banner});

  factory YouTubeVideo.fromJson(Map<String, dynamic> json,
      {bool fromPlayList = false}) {
    final snippet = json['snippet'];
    final thumbnail =
        snippet['thumbnails']['standard'] ?? snippet['thumbnails']['high'];
    String videoId;
    if (!fromPlayList) {
      videoId = json['contentDetails']['upload']['videoId'];
    } else {
      videoId = snippet['resourceId']['videoId'];
    }

    return YouTubeVideo(
        videoId: videoId,
        title: snippet['title'],
        description: snippet['description'],
        banner: thumbnail['url']);
  }
}
