import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_presenter.dart';
import 'package:picnic_app/features/chat/single_chat/widgets/single_chat_messages_list.dart';
import 'package:picnic_app/features/chat/widgets/chat_input/chat_input_bar.dart';
import 'package:picnic_app/features/chat/widgets/single_chat_app_bar.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/features/media_picker/widgets/media_picker.dart';
import 'package:picnic_app/ui/widgets/automatic_keyboard_hide.dart';
import 'package:picnic_app/ui/widgets/horizontal_drag_detector.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SingleChatPage extends StatefulWidget with HasPresenter<SingleChatPresenter> {
  const SingleChatPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SingleChatPresenter presenter;

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage>
    with PresenterStateMixin<SingleChatViewModel, SingleChatPresenter, SingleChatPage>, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    presenter.onInit();
    presenter.navigator.context = context;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    presenter.onAppLifecycleStateChange(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final white = colors.blackAndWhite.shade100;
    final darkBlue = colors.darkBlue.shade600;
    final gray = colors.blackAndWhite.shade600;
    final blue = colors.blue.shade600;

    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;
    final padding = EdgeInsets.only(
      bottom: bottomNavBarHeight,
    );

    return DarkStatusBar(
      child: stateObserver(
        builder: (context, state) {
          final selectedAttachments = state.pendingMessage.attachments;
          return Scaffold(
            backgroundColor: white,
            appBar: SingleChatAppBar(
              user: state.recipientUser,
              onTapChatSettings: () => presenter.onTapChatSettings(state.recipientUser),
              isLoading: state.isLoadingChatParticipants,
              chat: state.chat,
            ),
            body: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: HorizontalDragDetector(
                      onDrag: presenter.onDragStart,
                      onEnd: presenter.onDragEnd,
                      child: AutomaticKeyboardHide(
                        child: SingleChatMessagesList(
                          messages: state.displayableMessages,
                          onTapFriendAvatar: (message) => presenter.onTapFriendAvatar(message.authorId),
                          onTapOwnAvatar: () => presenter.onTapOwnAvatar(),
                          loadMore: presenter.loadMoreMessages,
                          now: state.now,
                          chatMessageContentActions: presenter.chatMessageContentActions,
                          dragOffset: state.dragOffset,
                        ),
                      ),
                    ),
                  ),
                  ChatInputBar(
                    isReplying: state.replyMessage.selected,
                    replyMessage: state.replyMessage.item,
                    sendMessageColor: darkBlue,
                    attachmentIconColor: state.isMediaPickerVisible ? blue : gray,
                    onTapCloseReply: presenter.onTapCloseReply,
                    onMessageUpdated: presenter.onMessageTextUpdated,
                    onTapSendMessage: state.sendMessageEnabled ? presenter.onTapSendNewMassage : null,
                    onTapAddAttachment: state.isChatInputAttachmentEnabled
                        ? presenter.onTapAddAttachment
                        : state.isChatInputAttachmentNativePickerEnabled
                            ? presenter.onTapNativePickerAttachment
                            : null,
                    onTapElectric: state.isChatInputElectricEnabled ? presenter.onTapElectric : null,
                    attachments: selectedAttachments,
                    onTapDeleteAttachment: presenter.onTapDeleteAttachment,
                    additionalBottomPadding: state.isMediaPickerVisible ? 0 : MediaQuery.of(context).padding.bottom,
                  ),
                  MediaPicker(
                    isVisible: state.isMediaPickerVisible,
                    presenter: presenter.mediaPickerPresenter,
                    clearSelected: state.clearSelectedMediaAttachment,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
