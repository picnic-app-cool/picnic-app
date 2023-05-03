import 'dart:ui';

import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_display_options.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_mediator.dart';

class PostOverlayInitialParams {
  const PostOverlayInitialParams({
    required this.post,
    required this.messenger,
    required this.reportId,
    required this.circleId,
    required this.displayOptions,
    this.maxCommentsCount = Constants.defaultCommentsPreviewCount,
    this.onTapComments,
    this.onTapBack,
    // this.showTimestamp = true,  todo change to non-required
  });

  final Post post;
  final PostOverlayMediator messenger;
  final PostDisplayOptions displayOptions;
  final Id reportId;
  final Id circleId;
  final int? maxCommentsCount;
  final VoidCallback? onTapComments;
  final VoidCallback? onTapBack;

  PostOverlayInitialParams copyWith({
    Post? post,
    PostOverlayMediator? messenger,
    PostDisplayOptions? displayOptions,
    Id? reportId,
    Id? circleId,
    int? maxCommentsCount,
    VoidCallback? onTapComments,
    VoidCallback? onTapBack,
  }) {
    return PostOverlayInitialParams(
      post: post ?? this.post,
      messenger: messenger ?? this.messenger,
      displayOptions: displayOptions ?? this.displayOptions,
      reportId: reportId ?? this.reportId,
      circleId: circleId ?? this.circleId,
      maxCommentsCount: maxCommentsCount ?? this.maxCommentsCount,
      onTapComments: onTapComments ?? this.onTapComments,
      onTapBack: onTapBack ?? this.onTapBack,
    );
  }
}
