import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_presenter.dart';
import 'package:picnic_app/features/chat/group_chat/widgets/group_chat_app_bar.dart';
import 'package:picnic_app/features/chat/group_chat/widgets/group_chat_messages_list.dart';
import 'package:picnic_app/features/chat/widgets/chat_input/chat_input_bar.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/features/media_picker/widgets/media_picker.dart';
import 'package:picnic_app/ui/widgets/automatic_keyboard_hide.dart';
import 'package:picnic_app/ui/widgets/horizontal_drag_detector.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class GroupChatPage extends StatefulWidget with HasPresenter<GroupChatPresenter> {
  const GroupChatPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final GroupChatPresenter presenter;

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage>
    with PresenterStateMixin<GroupChatViewModel, GroupChatPresenter, GroupChatPage> {
  @override
  void initState() {
    super.initState();
    presenter.onInit();
    presenter.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final darkBlue = colors.darkBlue.shade600;
    final gray = colors.blackAndWhite.shade600;
    final green = colors.blue.shade600;

    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;
    final padding = EdgeInsets.only(
      bottom: bottomNavBarHeight,
    );

    return DarkStatusBar(
      child: stateObserver(
        builder: (context, state) {
          final selectedAttachments = state.pendingMessage.attachments;
          return Scaffold(
            appBar: GroupChatAppBar(
              name: state.groupName,
              membersCount: state.membersCount,
              onlineCount: state.onlineCount,
              isOnlineCountVisible: state.isChatSettingOnlineUsersEnabled,
              onTapMore: presenter.onTapMore,
            ),
            body: Padding(
              padding: padding,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: HorizontalDragDetector(
                          onDrag: presenter.onDragStart,
                          onEnd: presenter.onDragEnd,
                          child: AutomaticKeyboardHide(
                            child: GroupChatMessagesList(
                              messages: state.displayableMessages,
                              onTapFriendAvatar: presenter.onTapFriendAvatar,
                              onTapOwnAvatar: presenter.onTapOwnAvatar,
                              loadMore: presenter.loadMoreMessages,
                              chatMessageContentActions: presenter.chatMessageContentActions,
                              dragOffset: state.dragOffset,
                              now: state.now,
                            ),
                          ),
                        ),
                      ),
                      ChatInputBar(
                        isReplying: state.replyMessage.selected,
                        replyMessage: state.replyMessage.item,
                        sendMessageColor: darkBlue,
                        attachmentIconColor: state.isMediaPickerVisible ? green : gray,
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
                        suggestedUsersToMention: state.suggestedUsersToMention,
                        usersToMention: state.usersToMention,
                        pendingMessage: state.pendingMessage,
                        onTapSuggestedMention: presenter.onTapSuggestedMention,
                        onMentionChanged: presenter.onMentionChanged,
                        additionalBottomPadding: state.isMediaPickerVisible ? 0 : MediaQuery.of(context).padding.bottom,
                      ),
                      MediaPicker(
                        isVisible: state.isMediaPickerVisible,
                        presenter: presenter.mediaPickerPresenter,
                        clearSelected: state.clearSelectedMediaAttachment,
                      ),
                    ],
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
