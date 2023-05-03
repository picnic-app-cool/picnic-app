import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/video_url.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content_input.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_secondary_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/video_player/picnic_video_player.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class UploadMediaPreview extends StatelessWidget {
  const UploadMediaPreview({
    super.key,
    required this.postContentInput,
    required this.onTapSwitchMedia,
  });

  final PostContentInput postContentInput;
  final VoidCallback onTapSwitchMedia;

  static const opacity = 0.3;
  static const borderRadius = 24.0;
  static const rightPadding = 12.0;
  static const bottomPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final contentWidget = postContentInput is ImagePostContentInput
        ? AspectRatio(
            aspectRatio: 1.0,
            child: Image.file(
              File((postContentInput as ImagePostContentInput).imageFilePath),
              fit: BoxFit.cover,
            ),
          )
        : postContentInput is VideoPostContentInput
            ? PicnicVideoPlayer(
                url: VideoUrl((postContentInput as VideoPostContentInput).videoFilePath),
                pausable: true,
                isInPreviewMode: true,
              )
            : const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          contentWidget,
          Positioned(
            right: rightPadding,
            bottom: bottomPadding,
            child: PicnicCameraSecondaryButton(
              color: theme.colors.blackAndWhite.shade100.withOpacity(opacity),
              icon: Assets.images.switchCamera.path,
              onTap: onTapSwitchMedia,
            ),
          ),
        ],
      ),
    );
  }
}
