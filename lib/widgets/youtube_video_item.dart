import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app_2/blocs/pages/master_bloc/master_bloc.dart';
import 'package:my_flutter_app_2/blocs/pages/master_bloc/master_events.dart';
import 'package:my_flutter_app_2/models/youtube_video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:my_flutter_app_2/utils/dialogs.dart';

class YouTubeVideoItem extends StatelessWidget {
  final VoidCallback onDismissed;
  final YouTubeVideo item;
  const YouTubeVideoItem({Key key, @required this.item, this.onDismissed})
      : assert(item != null),
        super(key: key);

  Widget _getView(BuildContext context, MasterBloc masterBloc) {
    return GestureDetector(
      onLongPress: () async {
        final value = await Dialogs.select(context,
        title: "Seleccione una opción", options: [
          DialogOption(label: "Compartir", value: 0),
          DialogOption(label: "Agregar a favoritos", value: 1),
        ]);

        if(value!=null){
          if(value==0){
            Share.share("https://www.youtube.com/watch?v=${item.videoId}");
          }
        }

        print("long press $value");
      },
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            masterBloc.add(MasterAddToHistory(item));
            FlutterYoutube.playYoutubeVideoByUrl(
                apiKey: "AIzaSyAUOpSlooSVnbdHiZ5bDvg9LE-B5lEstGE",
                videoUrl: "https://www.youtube.com/watch?v=${item.videoId}",
                autoPlay: true, //default falase
                fullScreen: true //default false
                );
          },
          child: AspectRatio(
            aspectRatio: 12 / 3,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 10)
              ]),
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
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                                child: Text(
                              item.description,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            )),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final masterBloc = BlocProvider.of<MasterBloc>(context);

    if (onDismissed != null) {
      return Dismissible(
        key: Key(item.videoId),
        onDismissed: (_) {
          if (onDismissed != null) {
            onDismissed();
          }
        },
        child: _getView(context, masterBloc),
      );
    }
    return _getView(context, masterBloc);
  }
}
