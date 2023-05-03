import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/features/posts/comment_chat/widgets/comment_chat_input_bar.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_presenter.dart';
import 'package:picnic_app/features/posts/widgets/comment_tree.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_comment_bar.dart';
import 'package:picnic_app/features/posts/widgets/post_in_feed_nav_bar_gap.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/show_more_text.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class TextPostFeedPage extends StatefulWidget with HasPresenter<TextPostFeedPresenter> {
  const TextPostFeedPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final TextPostFeedPresenter presenter;

  @override
  State<TextPostFeedPage> createState() => _TextPostFeedPageState();
}

class _TextPostFeedPageState extends State<TextPostFeedPage>
    with PresenterStateMixin<TextPostFeedViewModel, TextPostFeedPresenter, TextPostFeedPage> {
  static const _contentPadding = EdgeInsets.symmetric(horizontal: 16);
  final _textController = TextEditingController();
  final _scrollController = AutoScrollController();
  final _textInputFocusNode = FocusNode();
  final _newThoughtFocusNode = FocusNode();
  final _showMoreMaxHeightMultiplier = 0.4;
  final _showMoreMinHeightMultiplier = 0.2;
  double? _columnHeight;
  double? _bottomNavBarHeight;

  @override
  void initState() {
    super.initState();
    presenter.navigator.context = context;
    presenter.onInit();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _textInputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final showMoreStyle = styles.body20.copyWith(color: colors.green.shade600);
    final body30 = styles.body30.copyWith(color: blackAndWhite.shade900);
    _bottomNavBarHeight ??= BottomNavigationSizeQuery.of(context).height;

    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return DarkStatusBar(
          child: stateObserver(
            builder: (context, state) => SafeArea(
              bottom: false,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints size) {
                    _columnHeight ??= size.maxHeight;
                    final postOverlayViewModel = state.postOverlayViewModel;
                    final post = postOverlayViewModel.post;
                    return Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: _columnHeight,
                              width: size.maxWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (state.mode == PostDetailsMode.feed) ...[
                                    const PostInFeedNavbarGap(),
                                    const Gap(20),
                                  ],
                                  Padding(
                                    padding: _contentPadding,
                                    child: PostSummaryBar(
                                      author: post.author,
                                      post: post,
                                      onToggleFollow: presenter.postOverlayPresenter.onTapFollow,
                                      onTapTag: presenter.postOverlayPresenter.onTapShowCircle,
                                      onTapJoinCircle: presenter.postOverlayPresenter.onJoinCircle,
                                      onTapAuthor: presenter.postOverlayPresenter.onTapProfile,
                                      showTagBackground: true,
                                      padding: EdgeInsets.zero,
                                      showTimestamp: state.showTimestamp,
                                    ),
                                  ),
                                  const Gap(12),
                                  Padding(
                                    padding: _contentPadding,
                                    child: ShowMoreText(
                                      text: state.postContent.text,
                                      style: body30,
                                      maxWidth: size.maxWidth - _contentPadding.left - _contentPadding.right,
                                      maxHeight: _columnHeight! *
                                          (_newThoughtFocusNode.hasFocus
                                              ? _showMoreMinHeightMultiplier
                                              : _showMoreMaxHeightMultiplier),
                                      onTapShowMore: presenter.onTapShowMore,
                                    ),
                                  ),
                                  const Gap(12),
                                  const Padding(
                                    padding: _contentPadding,
                                    child: Divider(),
                                  ),
                                  const Gap(12),
                                  Padding(
                                    padding: _contentPadding,
                                    child: PostCommentBar(
                                      hasActionsBelow: postOverlayViewModel.showReportAction,
                                      bookmarkEnabled: postOverlayViewModel.savedPostsEnabled,
                                      onTapSend: presenter.onTapSend,
                                      likeButtonParams: PostBarLikeButtonParams(
                                        isLiked: post.iReacted,
                                        likes: post.likesCount.toString(),
                                        onTap: presenter.postOverlayPresenter.onTapHeart,
                                        overlayTheme: post.overlayTheme,
                                      ),
                                      commentsButtonParams: PostBarButtonParams(
                                        onTap: presenter.postOverlayPresenter.onTapChat,
                                        overlayTheme: post.overlayTheme,
                                        text: post.commentsCount.toString(),
                                      ),
                                      shareButtonParams: PostBarButtonParams(
                                        onTap: presenter.postOverlayPresenter.onTapShare,
                                        overlayTheme: post.overlayTheme,
                                        text: post.sharesCount.toString(),
                                      ),
                                      bookmarkButtonParams: PostBarButtonParams(
                                        onTap: presenter.postOverlayPresenter.onTapBookmark,
                                        overlayTheme: post.overlayTheme,
                                        text: post.savesCount.toString(),
                                        selected: post.iSaved,
                                      ),
                                      overlayTheme: post.overlayTheme,
                                      focusNode: _newThoughtFocusNode,
                                      canComment: state.post.circle.commentsEnabled,
                                    ),
                                  ),
                                  const Gap(12),
                                  if (state.mode != PostDetailsMode.preview)
                                    if (state.commentChatViewModel.isLoadingInitialPageOfComments)
                                      const Center(
                                        child: PicnicLoadingIndicator(),
                                      )
                                    else
                                      Flexible(
                                        child: CustomScrollView(
                                          physics: const NeverScrollableScrollPhysics(),
                                          slivers: [
                                            CommentTree(
                                              controller: _scrollController,
                                              commentsRoot: state.commentChatViewModel.rootComment,
                                              onTapMore: presenter.commentChatPresenter.onTapMore,
                                              onTap: presenter.postOverlayPresenter.onTapComment,
                                              onDoubleTap: presenter.commentChatPresenter.onDoubleTap,
                                              onLongPress: presenter.commentChatPresenter.onLongPress,
                                              onTapLike: presenter.commentChatPresenter.onTapLikeUnlike,
                                              onReply: _onTapReply,
                                              onLoadMore: presenter.commentChatPresenter.onLoadMore,
                                              onProfileTap: presenter.commentChatPresenter.onTapProfile,
                                              onTapLink: presenter.commentChatPresenter.onTapLink,
                                              collapsedCommentIds: state.commentChatViewModel.collapsedCommentIds,
                                            ),
                                          ],
                                        ),
                                      ),
                                  if (state.showMoreCommentsVisible) ...[
                                    Center(
                                      child: InkWell(
                                        onTap: presenter.onTapShowMore,
                                        child: Text(
                                          appLocalizations.seeMoreComments,
                                          style: showMoreStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                  if (state.openCommentsChatVisible) ...[
                                    Center(
                                      child: InkWell(
                                        onTap: presenter.onTapShowMore,
                                        child: Text(
                                          appLocalizations.openCommentsChat,
                                          style: showMoreStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                  const Gap(8),
                                  Gap(_bottomNavBarHeight!),
                                  if (state.mode != PostDetailsMode.feed) ...[
                                    const Gap(30),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (state.commentChatViewModel.isReplying) ...[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CommentChatInputBar(
                                replyingComment: state.commentChatViewModel.replyingComment,
                                textController: _textController,
                                textFieldTextColor: blackAndWhite.shade600,
                                hideAttachmentButton: !state.commentChatViewModel.shouldAttachmentBeVisible,
                                hideInstantCommandsButton: !state.commentChatViewModel.shouldInstantCommandsBeVisible,
                                onTapSend: _onTapSend,
                                onTapCancelReply: _onTapCancelReply,
                                focusNode: _textInputFocusNode,
                              ),
                              Gap(bottomInset),
                            ],
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTapSend() {
    final success = presenter.commentChatPresenter.onTapSend(_textController.text);
    if (success) {
      _textController.text = '';
    }
  }

  void _onTapCancelReply() {
    FocusScope.of(context).unfocus();
    presenter.commentChatPresenter.onTapCancelReply();
  }

  void _onTapReply(BuildContext context, TreeComment comment) {
    presenter.commentChatPresenter.onTapReply(comment);
    _textInputFocusNode.requestFocus();
  }
}
