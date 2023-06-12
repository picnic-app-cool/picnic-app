// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_presentation_model.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_mediator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/post_overlay.dart';
import 'package:picnic_app/features/posts/widgets/comment_fixed_list.dart';
import 'package:picnic_app/features/posts/widgets/post_in_feed_nav_bar_gap.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_bottom_navigation.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/utils/number_formatter.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PollPostPage extends StatefulWidget with HasPresenter<PollPostPresenter> {
  const PollPostPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PollPostPresenter presenter;

  @override
  State<PollPostPage> createState() => _PollPostPageState();
}

class _PollPostPageState extends State<PollPostPage>
    with PresenterStateMixin<PollPostViewModel, PollPostPresenter, PollPostPage> {
  double _commentBarHeight = 0;
  PostOverlayPresenter? _overlayPresenter;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final bottomNavBarHeight = PicnicBottomNavigation.barHeight + mediaQuery.padding.bottom;
    const postRelativeMinHeight = 1 / 2.2;
    return stateObserver(
      builder: (context, state) {
        final pollContent = state.pollContent;
        final displayOptions = state.displayOptions;
        return DarkStatusBar(
          child: SafeArea(
            bottom: displayOptions.detailsMode == PostDetailsMode.details,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0.0, -0.4),
                  child: Column(
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
                      const Gap(12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(pollContent.question, style: theme.styles.body30),
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final minPostSize = constraints.maxHeight * postRelativeMinHeight;
                            final showPostCommentBar = state.displayOptions.showPostCommentBar;
                            return Column(
                              children: [
                                const Gap(12),
                                Expanded(
                                  child: Padding(
                                    padding: showPostCommentBar
                                        ? const EdgeInsets.symmetric(horizontal: 16)
                                        : EdgeInsets.zero,
                                    child: PicnicPollPost(
                                      onVote: presenter.onVoted,
                                      onDoubleTap: () => _overlayPresenter?.onDoubleTapPost(),
                                      leftImage: pollContent.leftPollAnswer.imageUrl,
                                      rightImage: pollContent.rightPollAnswer.imageUrl,
                                      userImageUrl: state.user.profileImageUrl,
                                      leftVotes: pollContent.leftVotesPercentage,
                                      rightVotes: pollContent.rightVotesPercentage,
                                      vote: state.vote,
                                      withRoundedCorners: !state.displayOptions.showPostSummaryBarAbovePost,
                                    ),
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  appLocalizations.votesDynamicLabel(formatNumber(pollContent.votesTotal)),
                                  style: theme.styles.body20,
                                ),
                                if (showPostCommentBar)
                                  CommentFixedList(
                                    availableHeight: constraints.maxHeight - minPostSize,
                                    comments: state.comments,
                                    onTapReply: (comment) => _overlayPresenter?.onTapReply(comment),
                                    onTapLikeUnlike: (comment) => _overlayPresenter?.onTapLikeUnlikeComment(comment),
                                    onTapComment: (comment) => _overlayPresenter?.onTapComment(comment.toTreeComment()),
                                    onLongTapComment: (comment) => _overlayPresenter?.onLongPress(comment),
                                    onTapCommentAuthor: (id) => _overlayPresenter?.onTapProfile(id: id),
                                    onDoubleTapComment: (comment) => _overlayPresenter?.onDoubleTapComment(comment),
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
                ),
                PostOverlay(
                  key: ValueKey(state.post.id),
                  post: state.post,
                  reportId: state.reportId,
                  displayOptions: displayOptions,
                  messenger: PostOverlayMediator(
                    reportActionTaken: presenter.reportActionTaken,
                    postUpdated: presenter.postUpdated,
                    onUpdatedComments: presenter.onUpdatedComments,
                    onPresenterCreated: (presenter) => _overlayPresenter = presenter,
                    commentBarSizeChanged: (height) => setState(() => _commentBarHeight = height),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
