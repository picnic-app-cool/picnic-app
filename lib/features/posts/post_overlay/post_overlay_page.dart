import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/main/widgets/size_reporting_widget.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/comments_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_with_caption.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presentation_model.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/overlay_comment_section.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/post_caption.dart';
import 'package:picnic_app/features/posts/post_visibility_tracker.dart';
import 'package:picnic_app/features/posts/widgets/comment_list.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_comment_bar.dart';
import 'package:picnic_app/features/posts/widgets/post_in_feed_nav_bar_gap.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/automatic_keyboard_hide.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_bottom_navigation.dart';
import 'package:picnic_app/ui/widgets/ignore_automatic_keyboard_hide.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_heartbeat_animation.dart';

class PostOverlayPage extends StatefulWidget with HasPresenter<PostOverlayPresenter> {
  const PostOverlayPage({
    required this.presenter,
    super.key,
  });

  @override
  final PostOverlayPresenter presenter;

  @override
  State<PostOverlayPage> createState() => _PostOverlayPageState();

  /// convenience method to build text shadow for entire feed reliably and in standarized way.
  /// values are taken directly from figma https://www.figma.com/file/pVdXTU3gb7oDRVoZPXzvxV/Feed?t=I7QwIJx6fhbhLGZN-0
  /// optionally it allows you to specify opacity of the shadow relative to the default shadow's opacity, i.e:
  /// 0.5 opacity will mean 50% of 20% black color == 10% black color
  static Shadow textShadow(BuildContext context, {double? opacity}) {
    final color = PicnicTheme.of(context).colors.shadow50;
    return Shadow(
      color: color.withOpacity(color.opacity * (opacity ?? 1)),
      offset: const Offset(0, 1),
      //ignore: no-magic-number
      blurRadius: 4,
    );
  }
}

class _PostOverlayPageState extends State<PostOverlayPage>
    with PresenterStateMixin<PostOverlayViewModel, PostOverlayPresenter, PostOverlayPage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final whiteColor = colors.blackAndWhite.shade100;

    /// this padding makes sure that we move comment's bar up when keyboard is shown
    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;
    final bottomNavBarHeight = PicnicBottomNavigation.barHeight + mediaQuery.padding.bottom;

    return SafeArea(
      bottom: false,
      child: stateObserver(
        buildWhen: (prev, current) =>
            prev.displayOptions.detailsMode != current.displayOptions.detailsMode ||
            prev.displayOptions.overlaySize != current.displayOptions.overlaySize ||
            prev.comments != current.comments ||
            prev.shouldCommentsBeVisible != current.shouldCommentsBeVisible ||
            prev.shouldDetailsBeVisible != current.shouldDetailsBeVisible,
        builder: (context, state) {
          final postContent = state.post.content;
          final displayOptions = state.displayOptions;
          final postType = state.post.type;

          final postSummaryBar = !displayOptions.showPostSummaryBarAbovePost && displayOptions.showPostSummaryBar
              ? PostSummaryBar(
                  author: state.author,
                  post: state.post,
                  overlayTheme: state.post.overlayTheme,
                  onToggleFollow: presenter.onTapFollow,
                  onTapTag: presenter.onTapShowCircle,
                  onTapAuthor: presenter.onTapProfile,
                  onTapJoinCircle: presenter.onJoinCircle,
                  showTagBackground: true,
                  showTimestamp: displayOptions.showTimestamp,
                )
              : const SizedBox.shrink();

          return Padding(
            padding: EdgeInsets.only(
              bottom: (bottomInset > 0 && bottomInset >= bottomNavBarHeight) ? bottomInset : bottomNavBarHeight,
            ),
            child: PostVisibilityTracker(
              postId: state.post.id,
              child: AutomaticKeyboardHide(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    stateObserver(
                      buildWhen: (prev, current) => prev.heartLastAnimatedAt != current.heartLastAnimatedAt,
                      builder: (context, state) {
                        return PicnicHeartbeatAnimation(
                          heartLastAnimatedAt: state.heartLastAnimatedAt,
                        );
                      },
                    ),
                    if (state.shouldDetailsBeVisible)
                      IgnoreAutomaticKeyboardHide(
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (displayOptions.detailsMode != PostDetailsMode.report) ...[
                                  if (displayOptions.overlaySize == PostOverlaySize.fullscreen)
                                    const PostInFeedNavbarGap(),
                                ],
                                if (postType != PostType.image && postType != PostType.video) postSummaryBar,
                                const Spacer(),
                                if (displayOptions.commentsMode == CommentsMode.list) //
                                  Padding(
                                    padding: const EdgeInsets.only(right: 38),
                                    child: AnimatedOpacity(
                                      opacity: state.shouldCommentsBeVisible ? 1.0 : 0.0,
                                      duration: const Duration(milliseconds: 250),
                                      child: CommentList(
                                        comments: state.comments,
                                        onTapCommentAuthor: (id) => presenter.onTapProfile(id: id),
                                        onTapReply: presenter.onTapReply,
                                        onTapComment: (comment) => presenter.onTapComment(comment.toTreeComment()),
                                        onDoubleTapComment: presenter.onDoubleTapComment,
                                        onTapLikeUnlike: presenter.onTapLikeUnlikeComment,
                                        onLongTapComment: presenter.onLongPress,
                                      ),
                                    ),
                                  ),
                                if (displayOptions.commentsMode == CommentsMode.overlay) //
                                  if (state.shouldCommentsBeVisible) ...[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 38),
                                      child: IgnorePointer(
                                        ignoring: !state.shouldCommentsBeVisible,
                                        child: AnimatedOpacity(
                                          opacity: state.shouldCommentsBeVisible ? 1.0 : 0.0,
                                          duration: const Duration(milliseconds: 250),
                                          child: OverlayCommentSection(
                                            comments: state.comments,
                                            onTapCommentAuthor: (id) => presenter.onTapProfile(id: id),
                                            onTapReply: (comment) => presenter.onTapReply(comment),
                                            onTapLikeUnlike: (comment) => presenter.onTapLikeUnlikeComment(comment),
                                            onTapComment: (comment) => presenter.onTapComment(comment.toTreeComment()),
                                            onLongTapComment: (comment) => presenter.onLongPress(comment),
                                            onDoubleTapComment: (comment) => presenter.onDoubleTapComment(comment),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 52),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Spacer(),
                                        if (postType == PostType.image || postType == PostType.video)
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 8),
                                            child: postSummaryBar,
                                          ),
                                        if (postContent is PostWithCaption)
                                          PostCaption(
                                            text: (postContent as PostWithCaption).text,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (displayOptions.showPostCommentBar)
                              Align(
                                alignment: Alignment.bottomRight,
                                child: SizeReportingWidget(
                                  onSizeChange: (size) => presenter.commentBarHeightChanged(size.height),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: stateObserver(
                                          builder: (context, state) {
                                            final overlayTheme = state.post.overlayTheme;
                                            final contentStats = state.post.contentStats;
                                            final reactButtonsVertical = state.post.reactButtonsVertical;
                                            return stateListener(
                                              child: PostCommentBar(
                                                buttonsAreVertical: reactButtonsVertical,
                                                hasActionsBelow: state.showReportAction,
                                                bookmarkEnabled: state.savedPostsEnabled,
                                                likeButtonParams: PostBarLikeButtonParams(
                                                  isLiked: state.post.iLiked,
                                                  likes: contentStats.likes.toString(),
                                                  onTap: presenter.onTapLikePost,
                                                  overlayTheme: overlayTheme,
                                                  isVertical: reactButtonsVertical,
                                                ),
                                                dislikeButtonParams: PostBarButtonParams(
                                                  selected: state.post.iDisliked,
                                                  onTap: presenter.onTapDislikePost,
                                                  overlayTheme: overlayTheme,
                                                  isVertical: reactButtonsVertical,
                                                ),
                                                commentsButtonParams: PostBarButtonParams(
                                                  onTap: presenter.onTapChat,
                                                  overlayTheme: overlayTheme,
                                                  text: contentStats.comments.toString(),
                                                  isVertical: reactButtonsVertical,
                                                ),
                                                shareButtonParams: PostBarButtonParams(
                                                  onTap: presenter.onTapShare,
                                                  overlayTheme: overlayTheme,
                                                  text: contentStats.shares.toString(),
                                                  isVertical: reactButtonsVertical,
                                                ),
                                                bookmarkButtonParams: PostBarButtonParams(
                                                  onTap: presenter.onTapBookmark,
                                                  overlayTheme: overlayTheme,
                                                  text: contentStats.saves.toString(),
                                                  selected: state.post.context.saved,
                                                  isVertical: reactButtonsVertical,
                                                ),
                                                overlayTheme: overlayTheme,
                                                replyingComment: state.replyingComment,
                                                onTapCancelReply: presenter.onTapCancelReply,
                                                focusNode: _focusNode,
                                              ),
                                              listenWhen: (old, newModel) =>
                                                  old.replyingComment != newModel.replyingComment &&
                                                  newModel.replyingComment != const CommentPreview.empty(),
                                              listener: (BuildContext context, PostOverlayViewModel state) =>
                                                  _focusNode.requestFocus(),
                                            );
                                          },
                                        ),
                                      ),
                                      if (state.showReportAction) ...[
                                        const Gap(8),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                            child: PicnicButton(
                                              title: appLocalizations.reportActionsLabel,
                                              onTap: presenter.onTapReportActions,
                                              titleColor: colors.red,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
