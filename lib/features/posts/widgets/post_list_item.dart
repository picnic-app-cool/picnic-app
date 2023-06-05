import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/image_post/image_post_initial_params.dart';
import 'package:picnic_app/features/posts/image_post/image_post_page.dart';
import 'package:picnic_app/features/posts/link_post/link_post_initial_params.dart';
import 'package:picnic_app/features/posts/link_post/link_post_page.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_page.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_info_provider.dart';
import 'package:picnic_app/features/posts/text_post/text_post_initial_params.dart';
import 'package:picnic_app/features/posts/text_post/text_post_page.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_initial_params.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_page.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_initial_params.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_page.dart';
import 'package:picnic_app/features/posts/video_post/video_post_initial_params.dart';
import 'package:picnic_app/features/posts/video_post/video_post_page.dart';
import 'package:picnic_app/features/posts/widgets/post_action_detector.dart';

/// This is a stateful widget so that the rebuilds won't call `getIt` every time resulting in creating the pages
/// presenter and the whole MVP from scratch.
class PostListItem extends StatefulWidget {
  const PostListItem({
    super.key,
    required this.post,
    required this.onPostUpdated,
    this.postDetailsMode = PostDetailsMode.details,
    this.reportId = const Id.empty(),
    this.overlaySize = PostOverlaySize.fullscreen,
    required this.onReport,
    this.postsListInfoProvider,
    this.showPostCommentBar = true,
    this.backgroundColor,
    this.initiallyMuted = false,
    this.allowUnmute = true,
    this.showVideoControls = true,
    this.showPostSummaryBarAbovePost = false,
    required this.showTimestamp,
  });

  final Post post;
  final PostDetailsMode postDetailsMode;
  final Id reportId;
  final PostOverlaySize overlaySize;
  final Function(Post) onPostUpdated;
  final Function(Post) onReport;
  final PostsListInfoProvider? postsListInfoProvider;
  final bool showPostCommentBar;
  final Color? backgroundColor;

  /// see [VideoPostInitialParams.initiallyMuted]
  final bool initiallyMuted;

  /// see [VideoPostInitialParams.allowUnmute]
  final bool allowUnmute;

  final bool showVideoControls;
  final bool showTimestamp;
  final bool showPostSummaryBarAbovePost;

  @override
  State<PostListItem> createState() => PostListItemState();
}

@visibleForTesting
class PostListItemState extends State<PostListItem> {
  late Widget page;

  @override
  void initState() {
    super.initState();
    _createPage();
  }

  @override
  void didUpdateWidget(PostListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.post != widget.post) {
      setState(() {
        _createPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.post.type != PostType.text ? MediaQuery.of(context).size.height : null;
    return PostActionDetector(
      post: widget.post,
      onReport: (post) => widget.onReport(post),
      child: SizedBox(
        //this makes sure, that if the page is of the same type (i.e: video page, but the post did change underneath,
        // the whole widget is rebuilt from scratch
        key: ValueKey(widget.post.id),
        height: height,
        child: page,
      ),
    );
  }

  // ignore: long-method
  void _createPage() {
    switch (widget.post.type) {
      case PostType.text:
        switch (widget.postDetailsMode) {
          case PostDetailsMode.postsTab:
            page = getIt<TextPostProfilePage>(
              param1: TextPostProfileInitialParams(
                post: widget.post,
                mode: widget.postDetailsMode,
                onPostUpdated: widget.onPostUpdated,
                showTimestamp: widget.showTimestamp,
                showPostSummaryBarAbovePost: widget.showPostSummaryBarAbovePost,
              ),
            );
            break;
          //TODO (GS-7457) - remember to include PostDetailsMode.report in re-design of thought/text, poll and link : https://picnic-app.atlassian.net/browse/GS-7457
          case PostDetailsMode.report:
            page = getIt<TextPostPage>(
              param1: TextPostInitialParams(
                reportId: widget.reportId,
                post: widget.post,
                overlaySize: widget.overlaySize,
                mode: widget.postDetailsMode,
                onPostUpdated: widget.onPostUpdated,
              ),
            );
            break;
          case PostDetailsMode.preview:
          case PostDetailsMode.feed:
          case PostDetailsMode.details:
            page = getIt<TextPostFeedPage>(
              param1: TextPostFeedInitialParams(
                post: widget.post,
                mode: widget.postDetailsMode,
                onPostUpdated: widget.onPostUpdated,
                showTimestamp: widget.showTimestamp,
              ),
            );
            break;
        }
        break;
      case PostType.image:
        page = getIt<ImagePostPage>(
          param1: ImagePostInitialParams(
            reportId: widget.reportId,
            post: widget.post,
            overlaySize: widget.overlaySize,
            mode: widget.postDetailsMode,
            onPostUpdated: widget.onPostUpdated,
            showPostCommentBar: widget.showPostCommentBar,
            showTimestamp: widget.showTimestamp,
            showPostSummaryBarAbovePost: widget.showPostSummaryBarAbovePost,
          ),
        );
        break;
      case PostType.video:
        page = maybeGetIt<VideoPostPage>(
          orElse: () => VideoPostPage(
            initialParams: VideoPostInitialParams(
              reportId: widget.reportId,
              post: widget.post,
              mode: widget.postDetailsMode,
              onPostUpdated: widget.onPostUpdated,
              postsListInfoProvider: widget.postsListInfoProvider,
              showPostCommentBar: widget.showPostCommentBar,
              initiallyMuted: widget.initiallyMuted,
              allowUnmute: widget.allowUnmute,
              showControls: widget.showVideoControls,
              showTimestamp: widget.showTimestamp,
              showPostSummaryBarAbovePost: widget.showPostSummaryBarAbovePost,
            ),
          ),
        );
        break;
      case PostType.link:
        page = getIt<LinkPostPage>(
          param1: LinkPostInitialParams(
            post: widget.post,
            reportId: widget.reportId,
            overlaySize: widget.overlaySize,
            mode: widget.postDetailsMode,
            onPostUpdated: widget.onPostUpdated,
            showPostCommentBar: widget.showPostCommentBar,
            showTimestamp: widget.showTimestamp,
            showPostSummaryBarAbovePost: widget.showPostSummaryBarAbovePost,
          ),
        );
        break;
      case PostType.poll:
        page = getIt<PollPostPage>(
          param1: PollPostInitialParams(
            post: widget.post,
            reportId: widget.reportId,
            overlaySize: widget.overlaySize,
            onPostUpdated: widget.onPostUpdated,
            mode: widget.postDetailsMode,
            showPostCommentBar: widget.showPostCommentBar,
            showTimestamp: widget.showTimestamp,
            showPostSummaryBarAbovePost: widget.showPostSummaryBarAbovePost,
          ),
        );
        break;
      case PostType.unknown:
        page = const SizedBox.shrink();
        break;
    }
  }
}
