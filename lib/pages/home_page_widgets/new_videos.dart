import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app_2/models/youtube_video.dart';

class NewVideos extends StatelessWidget {
  final List<YouTubeVideo> items;

  const NewVideos({Key key, @required this.items})
      : assert(items != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        final YouTubeVideo item = items[index];
        return AspectRatio(
          aspectRatio: 12 / 3,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: CachedNetworkImage(
                      imageUrl: item.banner,
                      fit: BoxFit.cover,
                      height: double.infinity,
                    )),
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.title,
                            maxLines: 2,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                              child: Text(
                            item.description,
                            overflow: TextOverflow.fade,
                            style: TextStyle(fontWeight: FontWeight.w300),
                          )),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      }),
    );
  }
}
