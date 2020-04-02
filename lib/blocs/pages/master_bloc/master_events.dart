import 'package:my_flutter_app_2/models/youtube_video.dart';

abstract class MasterEvents {}

class MasterSetTab extends MasterEvents {
  final int tab;
  MasterSetTab(this.tab);
}

class MasterAddToHistory extends MasterEvents {
  final YouTubeVideo youTubeVideo;
  MasterAddToHistory(this.youTubeVideo);
}

class MasterRemoveFromHistory extends MasterEvents {
  final int index;
  MasterRemoveFromHistory(this.index);
}

class MasterLogOut extends MasterEvents {}
