import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/core/utils/scrollable_utils.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presentation_model.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presenter.dart';
import 'package:picnic_app/features/posts/comment_chat/comments_list_custom_scroll_view.dart';
import 'package:picnic_app/features/posts/comment_chat/widgets/comment_chat_input_bar.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/widgets/comments_key_storage.dart';
import 'package:picnic_app/features/posts/widgets/disabled_chat_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_container_button.dart';
import 'package:picnic_app/ui/widgets/dismiss_on_drag_insets_handler.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class CommentChatPage extends StatefulWidget with HasPresenter<CommentChatPresenter> {
  const CommentChatPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CommentChatPresenter presenter;

  @override
  State<CommentChatPage> createState() => _CommentChatPageState();
}

class _CommentChatPageState extends State<CommentChatPage>
    with PresenterStateMixin<CommentChatViewModel, CommentChatPresenter, CommentChatPage> {
  final _textController = TextEditingController();
  final _scrollController = AutoScrollController();
  final _textInputFocusNode = FocusNode();
  final _commentsKeyStorage = CommentsKeyStorage();

  /// anchor is the latest child in a scrollable area, used to determine real height of scrollable content
  final _anchorKey = GlobalKey();

  static const _borderWidth = 2.0;
  static const _sendIconEndPadding = 20.0;
  static const double _buttonSize = 48;

  double? _keepVisibleOffset;

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
    final blackAndWhite = theme.colors.blackAndWhite;
    final redColor = theme.colors.red;
    return DismissOnDragInsetsHandler(
      anchorKey: _anchorKey,
      scrollController: _scrollController,
      keepVisibleOffset: _keepVisibleOffset,
      onKeyboardStatusChanged: _onKeyboardStatusChanged,
      child: stateConsumer(
        listenWhen: (p, c) => p.scrollIndex != c.scrollIndex,
        listener: (_, state) => _scrollController.scrollToIndex(state.scrollIndex),
        builder: (context, state) => Scaffold(
          appBar: state.showAppBar
              ? PicnicAppBar(
                  titleText: appLocalizations.commentChatAppTitle,
                  actions: [
                    stateObserver(
                      builder: (context, state) {
                        final icon =
                            state.postSaved ? Assets.images.bookmarkChecked.path : Assets.images.bookmarkStroked.path;
                        return PicnicContainerButton(
                          buttonColor: blackAndWhite.shade100,
                          height: _buttonSize,
                          width: _buttonSize,
                          onTap: state.isSavingPost ? null : presenter.onTapBookmark,
                          child: Image.asset(
                            icon,
                            color: theme.colors.darkBlue.shade600,
                          ),
                        );
                      },
                    ),
                  ],
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                )
              : null,
          body: SafeArea(
            child: Column(
              children: [
                if (!state.showAppBar)
                  stateObserver(
                    builder: (context, state) => Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 14),
                      child: Text(
                        'comments: ${state.feedPost.contentStats.comments}',
                        style: theme.styles.body10,
                      ),
                    ),
                  ),
                Expanded(
                  child: stateObserver(
                    builder: (context, state) {
                      disposePresenter = state.shouldBeDisposed;
                      return CommentsListCustomScrollView(
                        scrollController: _scrollController,
                        anchorKey: _anchorKey,
                        focusTarget: state.focusTarget,
                        isLoadingComments: state.isLoadingInitialPageOfComments,
                        post: state.feedPost,
                        commentsRoot: state.rootComment,
                        commentsKeyStorage: _commentsKeyStorage,
                        onToggleFollow: presenter.onTapFollow,
                        onTapLike: presenter.onTapLikeUnlike,
                        onTapLink: presenter.onTapLink,
                        onTapTag: presenter.onTapTag,
                        onVoted: presenter.onVoted,
                        onTapReply: _onTapReply,
                        onLoadMore: presenter.onLoadMore,
                        onTapMore: presenter.onTapMore,
                        onDoubleTap: presenter.onDoubleTap,
                        onLongPress: presenter.onLongPress,
                        onTapProfile: presenter.onTapProfile,
                        user: state.user,
                        vote: state.vote,
                        isPolling: state.isPolling,
                        commentToBeHighlighted: state.reportedComment,
                        showPostSummary: state.showPostSummary,
                        onTap: presenter.onTap,
                        collapsedCommentIds: state.collapsedCommentIds,
                      );
                    },
                  ),
                ),
                if (state.feedPost.circle.commentsEnabled)
                  stateObserver(
                    builder: (context, state) => CommentChatInputBar(
                      replyingComment: state.replyingComment,
                      textController: _textController,
                      textFieldTextColor: blackAndWhite.shade600,
                      textFieldFillColor: blackAndWhite.shade100,
                      hideAttachmentButton: !state.shouldAttachmentBeVisible,
                      hideInstantCommandsButton: !state.shouldInstantCommandsBeVisible,
                      onTapSend: _onTapSend,
                      onTapCancelReply: presenter.onTapCancelReply,
                      focusNode: _textInputFocusNode,
                      endPadding: state.showAppBar ? 0.0 : _sendIconEndPadding,
                    ),
                  )
                else
                  DisabledChatView(text: appLocalizations.disabledCommentsLabel),
                if (state.showReportAction) ...[
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: PicnicButton(
                        title: appLocalizations.reportActionsLabel,
                        style: PicnicButtonStyle.outlined,
                        borderColor: redColor,
                        titleColor: redColor,
                        borderWidth: _borderWidth,
                        onTap: presenter.onTapReportActions,
                      ),
                    ),
                  ),
                  const Gap(20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onKeyboardStatusChanged(bool isOpened) {
    if (!isOpened) {
      setState(() => _keepVisibleOffset = null);
    }
  }

  void _onTapSend() {
    final success = presenter.onTapSend(_textController.text);
    if (success) {
      _textController.text = '';
    }
  }

  void _onTapReply(BuildContext context, TreeComment comment) {
    presenter.onTapReply(comment);
    final commentContext = _commentsKeyStorage.resolveContext(comment)!;
    setState(() => _keepVisibleOffset = getContextOffsetInScrollable(commentContext));
    _textInputFocusNode.requestFocus();
  }
}
