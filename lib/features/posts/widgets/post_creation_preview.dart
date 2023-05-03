import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/camera_permission_info.dart';
import 'package:picnic_app/features/posts/domain/post_creation_preview_type.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_page.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_page.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_page.dart';
import 'package:picnic_app/features/posts/post_creation_index/widgets/camera_permission_info_view.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_page.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_page.dart';

class PostCreationPreview extends StatelessWidget {
  const PostCreationPreview({
    Key? key,
    required this.selectedType,
    required this.types,
    required this.linkPostCreationPage,
    required this.textPostCreationPage,
    required this.pollPostCreationPage,
    required this.videoPostCreationPage,
    required this.imagePostCreationPage,
    required this.cameraPermissionInfo,
    this.onTapGoToSettings,
  }) : super(key: key);

  final PostCreationPreviewType selectedType;
  final List<PostCreationPreviewType> types;
  final TextPostCreationPage textPostCreationPage;
  final LinkPostCreationPage linkPostCreationPage;
  final PollPostCreationPage pollPostCreationPage;
  final VideoPostCreationPage videoPostCreationPage;
  final PhotoPostCreationPage imagePostCreationPage;
  final CameraPermissionInfo cameraPermissionInfo;
  final VoidCallback? onTapGoToSettings;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: types.indexOf(selectedType),
      children: types.map((type) {
        switch (type) {
          case PostCreationPreviewType.link:
            return linkPostCreationPage;
          case PostCreationPreviewType.image:
            return cameraPermissionInfo.showCameraPermissionInfo
                ? CameraPermissionInfoView(
                    cameraPermissionInfo: cameraPermissionInfo,
                    onTapGoToSettings: onTapGoToSettings,
                  )
                : imagePostCreationPage;
          case PostCreationPreviewType.video:
            return cameraPermissionInfo.showCameraPermissionInfo
                ? CameraPermissionInfoView(
                    cameraPermissionInfo: cameraPermissionInfo,
                    onTapGoToSettings: onTapGoToSettings,
                  )
                : videoPostCreationPage;
          case PostCreationPreviewType.poll:
            return pollPostCreationPage;
          case PostCreationPreviewType.text:
            return textPostCreationPage;
        }
      }).toList(),
    );
  }
}
