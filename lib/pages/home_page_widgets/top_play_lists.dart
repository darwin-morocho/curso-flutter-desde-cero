import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app_2/models/play_list.dart';
import 'package:my_flutter_app_2/utils/extras.dart';

class TopPlayLists extends StatefulWidget {
  final List<PlayList> items;

  const TopPlayLists({Key key, @required this.items})
      : assert(items != null && items.length > 0),
        super(key: key);
  @override
  _TopPlayListsState createState() => _TopPlayListsState();
}

class _TopPlayListsState extends State<TopPlayLists> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.5);
  ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    // _controller.addListener(() {
    //  // print("_controller.addListener");
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build TopPlayLists");
    final double itemWidth = MediaQuery.of(context).size.width * 0.75;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20, left: 10, bottom: 10),
          child: Text(
            "PARA FLUTTER DEVs",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        AspectRatio(
          aspectRatio: 7 / 4,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: NotificationListener(
                onNotification: (t) {
                  if (t is ScrollEndNotification) {
                    final int page =
                        (_controller.position.pixels / itemWidth).round();
                    _currentPage.value = page;
                  }
                  return false;
                },
                child: ListView(
                  controller: _controller,
                  physics: CustomScrollPhysics(itemDimension: itemWidth),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(widget.items.length, (int index) {
                    final PlayList item = widget.items[index];
                    return Container(
                      width: itemWidth,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: item.banner,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item.title,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      Extras.fromNow(item.publishedAt),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "Videos: ${item.itemCount}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                )),
          ),
        ),
        // CupertinoButton(
        //     child: Text("prev"),
        //     onPressed: () {
        //       // _controller.jumpTo((_currentPage.value + 1) * itemWidth);
        //       _controller.animateTo((_currentPage.value - 1) * itemWidth,
        //           duration: Duration(milliseconds: 300), curve: Curves.linear);
        //     }),
        // CupertinoButton(
        //     child: Text("next"),
        //     onPressed: () {
        //       // _controller.jumpTo((_currentPage.value + 1) * itemWidth);
        //       _controller.animateTo((_currentPage.value + 1) * itemWidth,
        //           duration: Duration(milliseconds: 300), curve: Curves.linear);
        //     }),
        ValueListenableBuilder(
            valueListenable: _currentPage,
            builder: (BuildContext _, int value, Widget w) {
              return Dots(count: widget.items.length, currentPage: value);
            })
      ],
    );
  }
}

class Dots extends StatelessWidget {
  final int count, currentPage;

  const Dots({Key key, @required this.count, @required this.currentPage})
      : assert(count != null && count > 0),
        assert(currentPage != null && currentPage >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:10,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(count, (index) {
          return Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: currentPage == index ? Colors.black : Colors.black12,
                shape: BoxShape.circle),
          );
        }),
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

  double _getPage(ScrollPosition position, double portion) {
    return (position.pixels + portion) / itemDimension;
  }

  double _getPixels(double page, double portion) {
    return (page * itemDimension) - portion;
  }

  double _getTargetPixels(
    ScrollPosition position,
    Tolerance tolerance,
    double velocity,
    double portion,
  ) {
    double page = _getPage(position, portion);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(page.roundToDouble(), portion);
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
    final portion = (position.extentInside - itemDimension) / 2;
    final double target =
        _getTargetPixels(position, tolerance, velocity, portion);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
