import 'package:bloc/bloc.dart';
import 'package:my_flutter_app_2/models/youtube_video.dart';
import 'master_events.dart';
import 'master_state.dart';

class MasterBloc extends Bloc<MasterEvents, MasterState> {
  @override
  MasterState get initialState => MasterState.initialState();

  @override
  Stream<MasterState> mapEventToState(MasterEvents event) async* {
    if (event is MasterSetTab) {
      yield this.state.copyWith(currentTab: event.tab);
    } else if (event is MasterAddToHistory) {
      yield* _addToHistory(event);
    } else if (event is MasterRemoveFromHistory) {
      yield* _removeFromHistory(event);
    } else if (event is MasterLogOut) {
      yield this.state.copyWith(history: [], currentTab: 0);
    } else if (event is MasterAddToFavorites) {
      yield* _addToFavorites(event);
    }
  }

  Stream<MasterState> _addToHistory(MasterAddToHistory event) async* {
    final int index = this
        .state
        .history
        .indexWhere((item) => item.videoId == event.youTubeVideo.videoId);

    if (index == -1) {
      // event.youTubeVideo
      final history = List<YouTubeVideo>.from(this.state.history);
      history.add(event.youTubeVideo);
      yield this.state.copyWith(history: history);
    }
  }

  Stream<MasterState> _addToFavorites(MasterAddToFavorites event) async* {
    final int index = this
        .state
        .favorites
        .indexWhere((item) => item.videoId == event.youTubeVideo.videoId);

    if (index == -1) {
      // event.youTubeVideo
      final favorites = List<YouTubeVideo>.from(this.state.favorites);
      favorites.add(event.youTubeVideo);
      yield this.state.copyWith(favorites: favorites);
    }
  }

  Stream<MasterState> _removeFromHistory(MasterRemoveFromHistory event) async* {
    final history = List<YouTubeVideo>.from(this.state.history);
    history.removeAt(event.index);
    yield this.state.copyWith(history: history);
  }
}
