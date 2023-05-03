import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_presenter.dart';
import 'package:picnic_app/features/chat/circle_chat/widgets/circle_chat_messages_list.dart';
import 'package:picnic_app/features/chat/widgets/chat_input/chat_input_bar.dart';
import 'package:picnic_app/features/chat/widgets/circle_chat_app_bar.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/features/media_picker/widgets/media_picker.dart';
import 'package:picnic_app/features/posts/widgets/disabled_chat_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/automatic_keyboard_hide.dart';
import 'package:picnic_app/ui/widgets/horizontal_drag_detector.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleChatPage extends StatefulWidget with HasPresenter<CircleChatPresenter> {
  const CircleChatPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CircleChatPresenter presenter;

  @override
  State<CircleChatPage> createState() => _CircleChatPageState();
}

class _CircleChatPageState extends State<CircleChatPage>
    with PresenterStateMixin<CircleChatViewModel, CircleChatPresenter, CircleChatPage>, WidgetsBindingObserver {
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
    final grey = colors.blackAndWhite.shade600;
    final lightGreen = colors.green.shade500;
    final green = colors.green.shade600;
    final disabledGreyColor = grey.withOpacity(0.5);

    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;
    final padding = EdgeInsets.only(
      bottom: bottomNavBarHeight,
    );

    return DarkStatusBar(
      child: Scaffold(
        appBar: CircleChatAppBar(
          emoji: state.emoji,
          image: state.image,
          onTapChatSettings: presenter.onTapCircleChatSettings,
          membersCount: state.membersCount,
          name: state.name,
        ),
        body: stateObserver(
          builder: (context, state) {
            final selectedAttachments = state.pendingMessage.attachments;
            return Padding(
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
                        child: CircleChatMessagesList(
                          messages: state.displayableMessages,
                          onTapFriendAvatar: presenter.onTapFriendAvatar,
                          onTapOwnAvatar: presenter.onTapOwnAvatar,
                          loadMore: presenter.loadMoreMessages,
                          chatMessageContentActions: presenter.chatMessageContentActions,
                          dragOffset: state.dragOffset,
                          now: state.now,
                          isUserBanned: state.isUserBanned,
                        ),
                      ),
                    ),
                  ),
                  if (!state.chatEnabled || !state.hasPermissionToChat)
                    DisabledChatView(text: appLocalizations.disabledChatLabel)
                  else if (state.isChatInputBarVisible)
                    ChatInputBar(
                      isReplying: state.replyMessage.selected,
                      replyMessage: state.replyMessage.item,
                      sendMessageColor: lightGreen,
                      attachmentIconColor: state.hasPermissionToAddAttachments
                          ? (state.isMediaPickerVisible ? green : grey)
                          : disabledGreyColor,
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
            );
          },
        ),
      ),
    );
  }
}
