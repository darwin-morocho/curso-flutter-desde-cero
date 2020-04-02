import 'package:flutter/material.dart';
import 'package:my_flutter_app_2/api/youtube_api.dart';
import 'package:my_flutter_app_2/models/youtube_video.dart';
import 'package:my_flutter_app_2/widgets/my_appbar.dart';
import 'package:my_flutter_app_2/widgets/video_item_shimmer.dart';
import 'package:my_flutter_app_2/widgets/youtube_video_item.dart';

class PlayListVideosPage extends StatefulWidget {
  final String playListId;

  const PlayListVideosPage({Key key, @required this.playListId})
      : super(key: key);
  @override
  _PlayListVideosPageState createState() => _PlayListVideosPageState();
}

class _PlayListVideosPageState extends State<PlayListVideosPage> {
  List<YouTubeVideo> _videos = [];
  bool _loading = true;
  YouTubeAPI _youTubeAPI =
      YouTubeAPI(apiKey: "AIzaSyAUOpSlooSVnbdHiZ5bDvg9LE-B5lEstGE");

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final List<YouTubeVideo> videos =
        await _youTubeAPI.getPlayListVideos(widget.playListId);

    setState(() {
      _loading = false;
      _videos.addAll(videos);
    });
  }

  Widget _shimmer() {
    return ListView.builder(
      itemBuilder: (_, index) {
        return VideoItemShimmer();
      },
      itemCount: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            MyAppbar(
              leftIcon: 'assets/icons/back.svg',
              rightIcon: 'assets/icons/chat.svg',
              onLeftClick: () => Navigator.pop(context),
              onRightClick: () {},
            ),
            Expanded(
                child: _loading
                    ? _shimmer()
                    : ListView.builder(
                        itemBuilder: (_, index) {
                          final YouTubeVideo item = _videos[index];
                          return YouTubeVideoItem(
                            item: item,
                          );
                        },
                        itemCount: _videos.length,
                      ))
          ],
        ),
      )),
    );
  }
}
