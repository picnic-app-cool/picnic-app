import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/widgets/chat_video_player/chat_video_player.dart';
import 'package:picnic_app/features/chat/widgets/chat_video_player/play_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class PicnicBlurredAttachment extends StatelessWidget {
  PicnicBlurredAttachment({
    super.key,
    required this.attachment,
    required this.heroTag,
    required this.onTapUnblur,
    required this.onTapAttachment,
    this.iconPath,
    this.iconColor,
    this.borderRadius,
    this.height,
    this.showIconSize = _iconSize,
  })  : showIconBackgroundSize = showIconSize + showIconSize,
        _imageBlur = attachment.isBlurred ? _defaultBlurRadius : 0.0;

  final Attachment attachment;
  final Object heroTag;
  final Function(Attachment) onTapUnblur;
  final VoidCallback onTapAttachment;
  final double? height;
  final double? borderRadius;
  final String? iconPath;
  final Color? iconColor;
  final double showIconSize;

  final double showIconBackgroundSize;
  static const _iconSize = 24.0;

  static const _defaultBlurRadius = 16.0;
  static const _iconBackgroundColorOpacity = 0.1;

  final double _imageBlur;

  @override
  Widget build(BuildContext context) {
    final iconPath = this.iconPath ?? Assets.images.show.path;
    final iconColor = this.iconColor ?? Colors.white;

    return ClipRRect(
      child: InkWell(
        onTap: attachment.isBlurred ? null : onTapAttachment,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            if (attachment.isVideo)
              Stack(
                alignment: Alignment.center,
                children: [
                  ChatVideoPlayer.preview(
                    url: attachment.url,
                    heroTag: heroTag,
                  ),
                  const PlayButton(),
                ],
              )
            else
              attachment.url.contains("http://") || attachment.url.contains("https://")
                  ? Image.network(
                      attachment.url,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(attachment.url),
                      fit: BoxFit.cover,
                    ),
            Positioned.fill(
              child: Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _imageBlur,
                    sigmaY: _imageBlur,
                  ),
                  child: Container(),
                ),
              ),
            ),
            if (attachment.isBlurred)
              Align(
                child: InkWell(
                  onTap: () => onTapUnblur(attachment),
                  child: Container(
                    width: showIconBackgroundSize,
                    height: showIconBackgroundSize,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(_iconBackgroundColorOpacity),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      iconPath,
                      width: showIconSize,
                      color: iconColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
