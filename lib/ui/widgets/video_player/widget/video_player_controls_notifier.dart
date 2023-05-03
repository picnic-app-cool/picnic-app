import 'package:flutter/material.dart';

class VideoPlayerControlsNotifier extends ChangeNotifier {
  VideoPlayerControlsNotifier({
    bool hideStuff = true,
  }) : _hideControls = hideStuff;

  bool _hideControls;

  bool get hideControls => _hideControls;

  set hideControls(bool value) {
    _hideControls = value;
    notifyListeners();
  }
}
