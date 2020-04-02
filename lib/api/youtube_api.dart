import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart' show required;
import 'package:my_flutter_app_2/models/play_list.dart';
import 'package:my_flutter_app_2/models/youtube_video.dart';

class YouTubeAPI {
  final String apiKey;

  YouTubeAPI({@required this.apiKey}) : assert(apiKey != null);

  String _getUrl(String endPoint, Map<String, String> queryParameters) {
    final uri = Uri(
        scheme: 'https',
        host: 'www.googleapis.com',
        path: '/youtube/v3/$endPoint',
        queryParameters: queryParameters);

    return uri.toString();
  }

  Future<List<PlayList>> getPlayLists(String channelId) async {
    try {
      final String url = _getUrl('playlists', {
        "part": "snippet,contentDetails",
        "channelId": channelId,
        "key": this.apiKey,
        "maxResults": "20"
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final List<PlayList> items = (parsed['items'] as List)
            .map<PlayList>((item) => PlayList.fromJson(item))
            .toList();
        return items;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<YouTubeVideo>> getNewVideos(String channelId) async {
    try {
      final String url = _getUrl('activities', {
        "part": "snippet,contentDetails",
        "channelId": channelId,
        "key": this.apiKey,
        "maxResults": "20"
      });
      print("url $url");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final List<YouTubeVideo> items = (parsed['items'] as List)
            .map<YouTubeVideo>((item) => YouTubeVideo.fromJson(item))
            .toList();
        return items;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<YouTubeVideo>> getPlayListVideos(String playListId) async {
    try {
      final String url = _getUrl('playlistItems', {
        "part": "snippet",
        "playlistId": playListId,
        "key": this.apiKey,
        "maxResults": "50"
      });
      print("url $url");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final List<YouTubeVideo> items = (parsed['items'] as List)
            .map<YouTubeVideo>(
                (item) => YouTubeVideo.fromJson(item, fromPlayList: true))
            .toList();
        return items;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
