// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/link_post/link_post_presentation_model.dart';
import 'package:picnic_app/features/posts/link_post/link_post_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_mediator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/post_overlay.dart';
import 'package:picnic_app/features/posts/widgets/comment_fixed_list.dart';
import 'package:picnic_app/features/posts/widgets/post_in_feed_nav_bar_gap.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_link_post.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';

class LinkPostPage extends StatefulWidget with HasPresenter<LinkPostPresenter> {
  const LinkPostPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final LinkPostPresenter presenter;

  @override
  State<LinkPostPage> createState() => _LinkPostPageState();
}

class _LinkPostPageState extends State<LinkPostPage>
    with PresenterStateMixin<LinkPostViewModel, LinkPostPresenter, LinkPostPage> {
  double _commentBarHeight = 0;
  PostOverlayPresenter? _overlayPresenter;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    final linkMetadata = state.linkContent.metadata;
    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;
    const postRelativeMinHeight = 1 / 2.5;

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
                          Gap(12),
                        ],
                      ),
                    if (!displayOptions.showPostSummaryBarAbovePost)
                      PostSummaryBar(
                        author: state.author,
                        post: state.post,
                        onToggleFollow: () => _overlayPresenter?.onTapFollow(),
                        onTapTag: () => _overlayPresenter?.onTapShowCircle(),
                        onTapJoinCircle: () => _overlayPresenter?.onJoinCircle(),
                        onTapAuthor: () => _overlayPresenter?.onTapProfile(),
                        showTagBackground: true,
                        onTapCircle: () => _overlayPresenter?.onTapCircleAvatar(),
                        showFollowButton: true,
                      ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final minPostSize = constraints.maxHeight * postRelativeMinHeight;
                          return Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      displayOptions.showPostCommentBar ? const EdgeInsets.all(16.0) : EdgeInsets.zero,
                                  child: PicnicLinkPost(
                                    onDoubleTap: () => _overlayPresenter?.onDoubleTapPost(),
                                    onTap: presenter.onTapLink,
                                    linkMetadata: linkMetadata,
                                    linkUrl: state.linkContent.linkUrl,
                                    height: double.infinity,
                                    withRoundedCorners: !displayOptions.showPostSummaryBarAbovePost,
                                  ),
                                ),
                              ),
                              if (!displayOptions.showPostSummaryBarAbovePost)
                                CommentFixedList(
                                  availableHeight: constraints.maxHeight - minPostSize,
                                  comments: state.comments,
                                  onTapComment: (comment) => _overlayPresenter?.onTapComment(comment.toTreeComment()),
                                  onDoubleTapComment: (comment) => _overlayPresenter?.onDoubleTapComment(comment),
                                  onTapLikeUnlike: (comment) => _overlayPresenter?.onTapLikeUnlikeComment(comment),
                                  onTapCommentAuthor: (id) => _overlayPresenter?.onTapProfile(id: id),
                                  onTapReply: (comment) => _overlayPresenter?.onTapReply(comment),
                                  onLongTapComment: (comment) => _overlayPresenter?.onLongPress(comment),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    const Gap(8),
                    Gap(_commentBarHeight + bottomNavBarHeight),
                  ],
                ),
                SafeArea(
                  top: displayOptions.detailsMode == PostDetailsMode.details,
                  bottom: displayOptions.detailsMode == PostDetailsMode.details,
                  child: PostOverlay(
                    key: ValueKey(state.post.id),
                    post: state.post,
                    displayOptions: displayOptions,
                    reportId: state.reportId,
                    messenger: PostOverlayMediator(
                      reportActionTaken: presenter.reportActionTaken,
                      postUpdated: presenter.postUpdated,
                      onUpdatedComments: presenter.onUpdatedComments,
                      onPresenterCreated: (presenter) => _overlayPresenter = presenter,
                      commentBarSizeChanged: (height) => setState(() => _commentBarHeight = height),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
