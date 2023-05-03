import 'package:flutter/material.dart' show Color;
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class TextPostInitialParams {
  const TextPostInitialParams({
    required this.post,
    required this.reportId,
    this.mode = PostDetailsMode.feed,
    this.overlaySize = PostOverlaySize.fullscreen,
    this.onPostUpdated,
    this.showPostCommentBar = true,
    this.backgroundColor,
    this.showTimestamp = true,
    this.showPostSummaryBarAbovePost = true,
  });

  final PostDetailsMode mode;

  final Post post;

  final PostOverlaySize overlaySize;

  final Id reportId;

  final Function(Post)? onPostUpdated;

  final bool showPostCommentBar;

  final bool showTimestamp;

  final Color? backgroundColor;

  final bool showPostSummaryBarAbovePost;
}
