import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app_2/api/account_api.dart';
import 'package:my_flutter_app_2/api/youtube_api.dart';
import 'package:my_flutter_app_2/models/play_list.dart';
import 'package:my_flutter_app_2/pages/home_page_widgets/top_play_lists.dart';
import 'package:my_flutter_app_2/widgets/circle_container.dart';
import 'package:shimmer/shimmer.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  AccountAPI _accountAPI = AccountAPI();
  YouTubeAPI _youTubeAPI =
      YouTubeAPI(apiKey: "AIzaSyAUOpSlooSVnbdHiZ5bDvg9LE-B5lEstGE");
  List<dynamic> _users = [];
  List<PlayList> _playLists = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final users = await _accountAPI.getUsers(1);
    final List<PlayList> playLists =
        await _youTubeAPI.getPlayLists("UCwXdFgeE9KYzlDdR7TG9cMw");
    setState(() {
      _users.addAll(users);
      _playLists.addAll(playLists);
      _isLoading = false;
    });
  }

  Widget _shimmer() {
    return Container(
      height: 120,
      child: ListView.builder(
        itemBuilder: (_, index) {
          return Shimmer(
              period: Duration(seconds: 2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffcccccc),
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(height: 13, width: 50, color: Colors.white)
                  ],
                ),
              ),
              gradient:
                  LinearGradient(colors: [Colors.white, Color(0xffdddddd)]));
        },
        itemCount: 7,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _isLoading
            ? _shimmer()
            : Column(
                children: <Widget>[
                  Container(
                    height: 110,
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        final dynamic item = _users[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 80),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: item['avatar'],
                                      placeholder: (_, __) => Center(
                                        child: CupertinoActivityIndicator(
                                          radius: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(item['first_name'])
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: _users.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  TopPlayLists(items: _playLists),
                ],
              )
      ],
    );
  }
}
