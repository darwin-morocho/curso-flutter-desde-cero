import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app_2/api/account_api.dart';
import 'package:my_flutter_app_2/api/youtube_api.dart';
import 'package:my_flutter_app_2/models/play_list.dart';
import 'package:my_flutter_app_2/utils/extras.dart';
import 'dart:math' as math;
import 'package:shimmer/shimmer.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  AccountAPI _accountAPI = AccountAPI();
  YouTubeAPI _youTubeAPI =
      YouTubeAPI(apiKey: "AIzaSyB6cuB4r9fc-ui6UJ46FntFtRhMe4vSARw");
  List<dynamic> _users = [];
  List<PlayList> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final users = await _accountAPI.getUsers(1);
    final items = await _youTubeAPI.getPlayLists("UCwXdFgeE9KYzlDdR7TG9cMw");
    setState(() {
      _users.addAll(users);
      _items.addAll(items);
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
                        color: Color(0xffaaaaaa),
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(height: 13, width: 50, color: Color(0xffaaaaaa))
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 20),
                    child: Text(
                      "TOP DEVELOPERS",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
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
                                      placeholder: (_, __) {
                                        return Center(
                                          child: CupertinoActivityIndicator(
                                            radius: 15,
                                          ),
                                        );
                                      },
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
                  Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 20),
                    child: Text(
                      "PARA FLUTTER DEVs",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  TopPlayLists(items: _items)
                ],
              )
      ],
    );
  }
}

class TopPlayLists extends StatefulWidget {
  final List<PlayList> items;

  TopPlayLists({Key key, @required this.items})
      : assert(items != null && items.length > 0),
        super(key: key);

  @override
  _TopPlayListsState createState() => _TopPlayListsState();
}

class _TopPlayListsState extends State<TopPlayLists> {
  ValueNotifier<int> _activePage = ValueNotifier<int>(0);
  PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.75;
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 7 / 4,
          child: NotificationListener(
            onNotification: (t) {
              if (t is ScrollEndNotification) {
                final int page = (_controller.position.pixels / width).round();
                _activePage.value = page;
              }
              return false;
            },
            child: ListView(
              controller: _controller,
              physics: CustomScrollPhysics(itemDimension: width),
              scrollDirection: Axis.horizontal,
              children: List.generate(widget.items.length, (index) {
                final item = widget.items[index];
                final mLeft =
                    10 * ((widget.items.length - index) / widget.items.length);
                final double mRight = 10 - mLeft;

                return Container(
                  width: width - 10,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(0, 2))
                      ]),
                  margin:
                      EdgeInsets.only(bottom: 15, left: mLeft, right: mRight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: item.thumbnail,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(Extras.fromNow(item.publishedAt))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        ValueListenableBuilder<int>(
            valueListenable: _activePage,
            builder: (_, value, w) {
              return Dots(
                controller: _controller,
                activePage: _activePage.value,
                itemsCount: widget.items.length,
              );
            })
      ],
    );
  }
}

class Dots extends StatelessWidget {
  final int itemsCount, activePage;
  final PageController controller;
  const Dots(
      {Key key,
      @required this.itemsCount,
      @required this.activePage,
      @required this.controller})
      : assert(controller != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            itemsCount,
            (index) => Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color:
                          activePage == index ? Colors.black45 : Colors.black12,
                      shape: BoxShape.circle),
                )),
      ),
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  final double itemDimension;

  CustomScrollPhysics({this.itemDimension, ScrollPhysics parent})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics(
        itemDimension: itemDimension, parent: buildParent(ancestor));
  }

  double _getPage(ScrollMetrics position, double portion) {
    // <--
    return (position.pixels + portion) / itemDimension;
    // -->
  }

  double _getPixels(double page, double portion) {
    // <--
    return (page * itemDimension) - portion;
    // -->
  }

  double _getTargetPixels(
    ScrollPosition position,
    Tolerance tolerance,
    double velocity,
    double portion,
  ) {
    // <--
    double page = _getPage(position, portion);
    // -->
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    // <--
    return _getPixels(page.roundToDouble(), portion);
    // -->
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);

    final Tolerance tolerance = this.tolerance;
    // <--
    final portion = (position.extentInside - itemDimension) / 2;
    final double target =
        _getTargetPixels(position, tolerance, velocity, portion);
    // -->
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
