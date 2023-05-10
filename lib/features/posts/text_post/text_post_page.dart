import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_mediator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/post_overlay.dart';
import 'package:picnic_app/features/posts/text_post/text_post_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post/text_post_presenter.dart';
import 'package:picnic_app/features/posts/text_post/widgets/full_text_view.dart';
import 'package:picnic_app/features/posts/text_post/widgets/text_post_view.dart';
import 'package:picnic_app/features/posts/widgets/post_in_feed_nav_bar_gap.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';

class TextPostPage extends StatefulWidget with HasPresenter<TextPostPresenter> {
  const TextPostPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final TextPostPresenter presenter;

  @override
  State<TextPostPage> createState() => _TextPostPageState();
}

class _TextPostPageState extends State<TextPostPage>
    with PresenterStateMixin<TextPostViewModel, TextPostPresenter, TextPostPage> {
  late double _commentBarHeight = 0;
  PostOverlayPresenter? _overlayPresenter;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;
    final shouldExpand = state.displayOptions.detailsMode == PostDetailsMode.postsTab;

    return DarkStatusBar(
      child: stateObserver(
        builder: (context, state) {
          final displayOptions = state.displayOptions;
          return SafeArea(
            bottom: displayOptions.detailsMode == PostDetailsMode.details,
            child: Stack(
              children: [
                Column(
                  children: [
                    if (displayOptions.detailsMode == PostDetailsMode.feed)
                      Column(
                        children: const [
                          PostInFeedNavbarGap(),
                          Gap(20),
                        ],
                      ),
                    Expanded(
                      child: state.expandedText.isEmpty
                          ? TextPostView(
                              post: state.post,
                              onDoubleTap: () => _overlayPresenter?.onDoubleTapPost(),
                              onTapCircleTag: () => _overlayPresenter?.onTapShowCircle(),
                              onTapFollow: () => _overlayPresenter?.onTapFollow(),
                              onTapAuthor: () => _overlayPresenter?.onTapProfile(),
                              onTapExpand: presenter.onTapExpand,
                              onTapComment: (comment) => _overlayPresenter?.onTapComment(comment.toTreeComment()),
                              onDoubleTapComment: (comment) => _overlayPresenter?.onDoubleTapComment(comment),
                              comments: state.comments,
                              commentBarHeight: _commentBarHeight,
                              onTapJoinCircle: () => _overlayPresenter?.onJoinCircle(),
                              onTapReply: (comment) => _overlayPresenter?.onTapReply(comment),
                              onTapLikeUnlike: (comment) => _overlayPresenter?.onTapLikeUnlikeComment(comment),
                              onLongTapComment: (comment) => _overlayPresenter?.onLongPress(comment),
                              onTapCommentAuthor: (id) => _overlayPresenter?.onTapProfile(id: id),
                              padding: !displayOptions.showPostCommentBar ? EdgeInsets.zero : null,
                              shouldExpand: shouldExpand,
                            )
                          : FullTextView(
                              post: state.post,
                              text: state.expandedText,
                              onTapCompress: presenter.onTapCompress,
                            ),
                    ),
                    if (!shouldExpand) const Gap(8),
                    if (displayOptions.showPostCommentBar) Gap(_commentBarHeight + bottomNavBarHeight),
                  ],
                ),
                PostOverlay(
                  key: ValueKey(state.post.id),
                  post: state.post,
                  reportId: state.reportId,
                  messenger: PostOverlayMediator(
                    onPresenterCreated: (presenter) => _overlayPresenter = presenter,
                    reportActionTaken: presenter.reportActionTaken,
                    postUpdated: presenter.postUpdated,
                    onUpdatedComments: presenter.onUpdatedComments,
                    commentBarSizeChanged: (newHeight) => setState(() => _commentBarHeight = newHeight),
                  ),
                  displayOptions: displayOptions,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
