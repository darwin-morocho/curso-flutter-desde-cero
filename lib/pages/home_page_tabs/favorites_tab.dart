import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_app_2/blocs/pages/master_bloc/master_bloc.dart';
import 'package:my_flutter_app_2/blocs/pages/master_bloc/master_events.dart';
import 'package:my_flutter_app_2/blocs/pages/master_bloc/master_state.dart';
import 'package:my_flutter_app_2/models/youtube_video.dart';
import 'package:my_flutter_app_2/widgets/youtube_video_item.dart';


class FavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MasterBloc>(context);

    return BlocBuilder<MasterBloc, MasterState>(
      builder: (_, state) {
        if (state.favorites.length == 0) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset('assets/icons/box.svg', width: 80),
                SizedBox(height: 10),
                Text("No hay datos para mostrar"),
              ],
            ),
          );
        }
        return ListView.builder(
          itemBuilder: (_, index) {
            final YouTubeVideo item = state.favorites[index];
            return YouTubeVideoItem(
              item: item,
              onDismissed: () {
               // bloc.add(MasterRemoveFromHistory(index));
              },
            );
          },
          itemCount: state.favorites.length,
        );
      },
      condition: (prevState, newState) =>
          prevState.favorites.length != newState.favorites.length,
    );
  }
}
