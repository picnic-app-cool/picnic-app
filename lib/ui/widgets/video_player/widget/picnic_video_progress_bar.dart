import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/scrubbing_progress_bar.dart';
import 'package:picnic_app/ui/widgets/video_player/widget/video_scrubbing_progress_colors.dart';
import 'package:video_player/video_player.dart';

class PicnicVideoProgressBar extends StatelessWidget {
  PicnicVideoProgressBar(
    this.controller, {
    this.height = kToolbarHeight,
    VideoScrubbingProgressColors? colors,
    this.onDragEnd,
    this.onDragStart,
    this.onDragUpdate,
    Key? key,
  })  : colors = colors ?? VideoScrubbingProgressColors(),
        super(key: key);

  final double height;
  final VideoPlayerController controller;
  final VideoScrubbingProgressColors colors;
  final Function()? onDragStart;
  final Function()? onDragEnd;
  final Function()? onDragUpdate;

  static const _barHeight = 8.0;
  static const _handleHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    return ScrubbingProgressBar(
      controller,
      barHeight: _barHeight,
      handleHeight: _handleHeight,
      drawShadow: true,
      colors: colors,
      onDragEnd: onDragEnd,
      onDragStart: onDragStart,
      onDragUpdate: onDragUpdate,
    );
  }
}
