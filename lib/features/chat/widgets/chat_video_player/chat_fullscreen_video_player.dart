import 'package:chewie/chewie.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class ChatFullscreenVideoPlayer extends StatelessWidget {
  const ChatFullscreenVideoPlayer({
    required this.chewieController,
    required this.heroTag,
  });

  final ChewieController chewieController;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      backgroundColor: Colors.transparent,
      onDismissed: () => Navigator.of(context).pop(),
      direction: DismissiblePageDismissDirection.multi,
      child: Hero(
        tag: heroTag,
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: Chewie(
            controller: chewieController,
          ),
        ),
      ),
    );
  }
}
