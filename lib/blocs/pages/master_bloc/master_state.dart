import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show required;
import 'package:my_flutter_app_2/models/youtube_video.dart';

class MasterState extends Equatable {
  final int currentTab;
  final List<YouTubeVideo> history;

  MasterState({@required this.currentTab, @required this.history});

  static MasterState initialState() => MasterState(currentTab: 0, history: []);

  MasterState copyWith({int currentTab, List<YouTubeVideo> history}) {
    return MasterState(
        currentTab: currentTab ?? this.currentTab,
        history: history ?? this.history);
  }

  @override
  List<Object> get props => [currentTab, history];
}
