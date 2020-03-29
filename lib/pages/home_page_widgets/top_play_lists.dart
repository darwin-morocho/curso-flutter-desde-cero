import 'package:cached_network_image/cached_network_image.dart';
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
  ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    print("build TopPlayLists");
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
          aspectRatio: 8 / 5,
          child: Container(
            child: PageView(
              onPageChanged: (int page) {
                _currentPage.value = page;
              },
              children: List.generate(widget.items.length, (int index) {
                final PlayList item = widget.items[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            ),
          ),
        ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
