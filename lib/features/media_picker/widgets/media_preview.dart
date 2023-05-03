import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/widgets/chat_video_player/play_button.dart';

class MediaPreview extends StatelessWidget {
  const MediaPreview({required this.attachment, super.key});

  final Attachment attachment;

  @override
  Widget build(BuildContext context) {
    final cacheWidth = MediaQuery.of(context).size.width.toInt();

    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: Image.file(
            File(attachment.isVideo ? attachment.thumbUrl : attachment.url),
            fit: BoxFit.cover,
            cacheWidth: cacheWidth,
          ),
        ),
        if (attachment.isVideo) const PlayButton.small(),
      ],
    );
  }
}
