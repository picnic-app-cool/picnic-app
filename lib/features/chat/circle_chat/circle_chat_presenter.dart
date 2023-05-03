import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/notifications/notification.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_message.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_sender.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_action.dart';
import 'package:picnic_app/features/chat/domain/model/circle_chat_settings_page_result.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/message_action_result.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';
import 'package:picnic_app/features/chat/domain/use_cases/chat_messages_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/save_attachment_use_case.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_initial_params.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_initial_params.dart';
import 'package:picnic_app/features/chat/message_actions/model/message_actions_open_event.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_actions.dart';
import 'package:picnic_app/features/circles/domain/use_cases/ban_user_use_case.dart';
import 'package:picnic_app/features/image_picker/utils/image_source_type.dart';
import 'package:picnic_app/features/in_app_events/domain/use_cases/add_in_app_notifications_filter_use_case.dart';
import 'package:picnic_app/features/in_app_events/domain/use_cases/remove_in_app_notifications_filter_use_case.dart';
import 'package:picnic_app/features/media_picker/media_picker_presenter.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/utils/image_type_to_permission.dart';

class CircleChatPresenter extends Cubit<CircleChatViewModel> with SubscriptionsMixin, MediaPickerMediator {
  CircleChatPresenter(
    CircleChatPresentationModel model,
    this.navigator,
    this.mediaPickerPresenter,
    this._saveAttachmentUseCase,
    this._requestRuntimePermissionUseCase,
    this._appInfoStore,
    this._chatMessagesUseCase,
    this._banUserUserCase,
    this._addInAppNotificationsFilterUseCase,
    this._removeInAppNotificationsFilterUseCase,
    this._logAnalyticsEventUseCase,
  ) : super(model) {
    mediaPickerPresenter.setMediator(this);
  }

  final CircleChatNavigator navigator;
  final MediaPickerPresenter mediaPickerPresenter;
  final SaveAttachmentUseCase _saveAttachmentUseCase;
  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final AppInfoStore _appInfoStore;
  final ChatMessagesUseCase _chatMessagesUseCase;
  final BanUserUseCase _banUserUserCase;
  final AddInAppNotificationsFilterUseCase _addInAppNotificationsFilterUseCase;
  final RemoveInAppNotificationsFilterUseCase _removeInAppNotificationsFilterUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  static const _updateChatMessagesSubscription = "updateChatMessagesSubscription";

  ChatMessageContentActions get chatMessageContentActions => ChatMessageContentActions.empty().copyWith(
        onMessageSelected: onMessageSelected,
        onMessageLongPress: onMessageLongPress,
        onTapUnblurAttachment: onTapUnblurAttachment,
        onTapAttachment: onTapAttachment,
        onDoubleTapMessage: onDoubleTapMessage,
        onTapLink: onTapLink,
        onTapPdf: onTapPdf,
        onTapFriendProfile: onTapFriendAvatar,
      );

  CircleChatPresentationModel get _model => state as CircleChatPresentationModel;

  Future<void> onInit() async {
    unawaited(_startMessagesChangeListening());
    _addInAppNotificationsFilterUseCase.execute(_circleChatNotificationsFilter);
  }

  @override
  Future<void> close() async {
    _removeInAppNotificationsFilterUseCase.execute(_circleChatNotificationsFilter);
    return super.close();
  }

  @override
  void onSelectedAttachmentsChanged({required List<Attachment> attachments}) {
    tryEmit(
      _model.copyWith(
        pendingMessage: _model.pendingMessage.copyWith(attachments: attachments),
      ),
    );
  }

  @override
  Future<void> onDocumentsPicked({required List<Attachment> documents}) async {
    for (final document in documents) {
      await _sendDocument(document);
    }
  }

  Future<void> onTapCircleChatSettings() async {
    final circle = _model.circle.toCircle(chat: _model.chat.toBasicChat());
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSettingsTap,
      ),
    );
    final result = await navigator.openCircleChatSettingsBottomSheet(
      CircleChatSettingsInitialParams(
        circle: circle,
        onCircleChanged: (circle) => tryEmit(
          _model.copyWith(
            chat: _model.chat.copyWith(circle: circle.toBasicCircle()),
          ),
        ),
      ),
    );
    if (result == CircleChatSettingsPageResult.didLeftCircle) {
      navigator.close();
    }
  }

  Future<void> loadMoreMessages() => _chatMessagesUseCase
      .execute(
        action: ChatMessagesAction.loadMore(),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void onMessageTextUpdated(String value) => tryEmit(
        _model.byUpdatingPendingMessage(
          pendingMessage: _model.pendingMessage.byUpdatingContent(value),
        ),
      );

  void onTapCloseReply() => _removeReplyMessage();

  void onTapAddAttachment() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatAttachmentButton,
      ),
    );
    if (state.hasPermissionToAddAttachments) {
      tryEmit(_model.byTogglingMediaPickerVisibility());
    } else {
      _showNoPermissionToAddAttachments();
    }
  }

  Future<void> onTapNativePickerAttachment() {
    if (state.hasPermissionToAddAttachments) {
      return mediaPickerPresenter.onTapNativePicker();
    }
    return _showNoPermissionToAddAttachments();
  }

  void onTapDeleteAttachment(Attachment attachment) => mediaPickerPresenter.onTapDeleteAttachment(attachment);

  void onTapAttachment(ChatMessage message) {
    navigator.openFullscreenAttachment(
      FullscreenAttachmentInitialParams(message: message),
    );
  }

  void onTapUnblurAttachment(Attachment attachment) => _chatMessagesUseCase
      .execute(
        action: ChatMessagesAction.unblur(attachment.id),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void onTapElectric() => notImplemented;

  void onMessageSelected(ChatMessage selectedMessage) => tryEmit(
        _model.byUpdatingSelectedMessage(
          selectedMessage: selectedMessage,
        ),
      );

  void onTapFriendAvatar(Id userId) => navigator.openPublicProfile(
        PublicProfileInitialParams(userId: userId),
      );

  void onTapOwnAvatar() => navigator.openPrivateProfile(const PrivateProfileInitialParams());

  Future<void> onTapSendNewMassage() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSendButton,
      ),
    );
    if (_model.pendingMessage.content.isEmpty && _model.pendingMessage.attachments.isEmpty) {
      return;
    }

    final sendAction = ChatMessagesAction.sendMessage(
      message: _model.pendingMessage,
      replyToMessage: _model.replyMessage.selected ? _model.replyMessage.item : null,
    );

    _removeReplyMessage();
    _removePendingMessage();
    _closeMediaPicker();

    await _chatMessagesUseCase
        .execute(
          action: sendAction,
        )
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> onDoubleTapMessage(ChatMessage chatMessage) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatMessageLikeDoubleTap,
      ),
    );
    return _chatMessagesUseCase
        .execute(
          action: ChatMessagesAction.reaction(chatMessage, ChatMessageReactionType.heart()),
        )
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> onMessageLongPress(MessageActionsOpenEvent event) async {
    final result = await navigator.openMessageActions(
      MessageActionsInitialParams(
        event: event,
        popupMenuItems: _filterPopupMenuItems(event),
      ),
    );

    result?.when(
      popUpMenuItemAction: _onTapPopUpMenuItem,
      chatMessageReactionAction: _onTapReaction,
    );
  }

  void onTapLink(String url) => navigator.openWebView(url);

  void onDragStart(double offset) {
    tryEmit(_model.copyWith(dragOffset: offset));
  }

  void onDragEnd() {
    tryEmit(_model.copyWith(dragOffset: 0));
  }

  Future<void> onTapPdf(Attachment attachment) => navigator.openWebView(attachment.url);

  void onAppLifecycleStateChange(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _chatMessagesUseCase.execute(action: ChatMessagesAction.disconnect());
      closeSubscription(_updateChatMessagesSubscription);
    } else if (state == AppLifecycleState.resumed) {
      onInit();
    }
  }

  //ignore: long-method
  List<PopUpMenuItem> _filterPopupMenuItems(MessageActionsOpenEvent event) {
    final chatMessage = event.displayableMessage.chatMessage;
    final chatMessageSender = chatMessage.chatMessageSender;
    final circlePermissions = _model.circle.permissions;

    if (chatMessage.isNotSent) {
      return [PopUpMenuItem.resendAction(), PopUpMenuItem.deleteMessageAction()];
    }

    final popupMenuItems = <PopUpMenuItem>[
      PopUpMenuItem.replyAction(),
    ];

    if (chatMessage.content.isNotEmpty) {
      popupMenuItems.add(PopUpMenuItem.copyTextAction());
    }

    if (chatMessage.attachments.isNotEmpty) {
      popupMenuItems.add(PopUpMenuItem.saveAttachmentsAction(count: chatMessage.attachments.length));
    }

    final isFriendMessage = chatMessageSender == ChatMessageSender.friend;

    if (isFriendMessage) {
      if (circlePermissions.canManageUsers) {
        popupMenuItems.add(PopUpMenuItem.banUserAction());
      }
      if (circlePermissions.canManageMessages) {
        popupMenuItems.add(PopUpMenuItem.deleteMessageAction());
        popupMenuItems.add(PopUpMenuItem.deleteMultipleMessagesAction());
      }
    }

    if (chatMessageSender == ChatMessageSender.user) {
      popupMenuItems.add(PopUpMenuItem.deleteMessageAction());
    }

    if (isFriendMessage) {
      popupMenuItems.add(PopUpMenuItem.reportAction());
    }

    return popupMenuItems;
  }

  Future<void> _showNoPermissionToAddAttachments() => navigator.showDisabledBottomSheet(
        title: appLocalizations.noAttachmentsPermissionsTitle,
        description: appLocalizations.noAttachmentsPermissionsDescription,
        onTapClose: () => navigator.close(),
      );

  void _onTapPopUpMenuItem(PopUpMenuItem popUpMenuItem) => popUpMenuItem.when(
        report: () => _onTapReport(),
        reply: () => _onTapReplyAction(),
        copy: () => _onTapCopy(),
        saveAttachments: () => _onTapSaveAttachments(),
        delete: () => _onTapDeleteMessageAction(),
        deleteMultipleMessages: notImplemented,
        ban: () => _banUser(),
        resend: () => _onTapResendMessageAction(),
      );

  Future<void> _onTapReaction(ChatMessageReactionType reactionType) => _chatMessagesUseCase
      .execute(
        action: ChatMessagesAction.reaction(_model.selectedMessage, reactionType),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  Future<void> _banUser() async {
    final userId = _model.selectedMessage.author.id;
    final circleId = _model.circle.id;

    await _banUserUserCase
        .execute(
          userId: userId,
          circleId: circleId,
        )
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> _onTapCopy() => _chatMessagesUseCase
      .execute(
        action: ChatMessagesAction.copy(_model.selectedMessage),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (_) => navigator.showMessageCopiedToast(),
      );

  Future<void> _onTapSaveAttachments() async {
    await _requestRuntimePermissionUseCase
        .execute(
          permission: permissionByImageSourceType(
            ImageSourceType.gallery,
            info: _appInfoStore.appInfo.deviceInfo,
          ),
        ) //
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (status) async {
            if (status == RuntimePermissionStatus.granted) {
              await _saveAttachments();
            } else {
              await navigator.showNoGalleryAccess();
            }
          },
        );
  }

  Future<void> _saveAttachments() async {
    final attachments = _model.selectedMessage.attachments;
    final count = attachments.length;
    final future = attachments //
        .map(
          (attachment) => _saveAttachmentUseCase.execute(
            attachment: attachment,
            username: _model.selectedMessage.authorFormattedUsername,
          ),
        )
        .concat();
    await navigator.showSavingAttachmentsToast(
      count: count,
      delay: future.doOn(
        success: (_) => navigator.showAttachmentsSavedToast(count: count),
      ),
    );
  }

  Future<void> _startMessagesChangeListening() => _chatMessagesUseCase
      .execute(
        action: ChatMessagesAction.init(chatIds: [_model.chat.id]),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (stream) => listenTo<PaginatedList<DisplayableChatMessage>>(
          stream: stream,
          subscriptionId: _updateChatMessagesSubscription,
          onChange: (messages) => tryEmit(
            _model.byUpdatingDisplayableMessages(
              displayableMessages: messages.mapItems(
                (message) => message.copyWith(showAuthor: true),
              ),
            ),
          ),
        ),
      );

  Future<void> _onTapReport() async {
    final reportSuccessful = await navigator.openReportForm(
          ReportFormInitialParams(
            circleId: _model.circle.id,
            entityId: _model.selectedMessage.id,
            contentAuthorId: _model.selectedMessage.authorId,
            reportEntityType: ReportEntityType.message,
          ),
        ) ??
        false;
    if (reportSuccessful) {
      navigator.close();
    }
  }

  void _onTapReplyAction() {
    tryEmit(
      _model.byUpdatingReplyMessage(
        replyMessage: _model.replyMessage.copyWith(
          item: _model.selectedMessage,
          selected: true,
        ),
      ),
    );
  }

  Future<void> _onTapDeleteMessageAction() => _chatMessagesUseCase
      .execute(
        action: ChatMessagesAction.deleteMessage(_model.selectedMessage),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  Future<void> _onTapResendMessageAction() {
    return _chatMessagesUseCase
        .execute(
          action: ChatMessagesAction.resendMessage(message: _model.selectedMessage),
        )
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void _removeReplyMessage() => tryEmit(
        _model.byUpdatingReplyMessage(
          replyMessage: _model.replyMessage.copyWith(
            selected: false,
          ),
        ),
      );

  void _removePendingMessage() => tryEmit(
        _model.byUpdatingPendingMessage(
          pendingMessage: const ChatMessage.empty(),
        ),
      );

  void _closeMediaPicker() {
    if (_model.isMediaPickerVisible) {
      tryEmit(
        _model.byTogglingMediaPickerVisibility(clearSelectedMediaAttachment: true),
      );
    }
  }

  bool _circleChatNotificationsFilter(Notification notification) {
    return notification is NotificationMessage && notification.chatId == _model.chat.id;
  }

  Future<void> _sendDocument(Attachment document) async {
    final sendAction = ChatMessagesAction.sendMessage(
      message: const ChatMessage.empty().copyWith(attachments: [document]),
      replyToMessage: null,
    );

    await _chatMessagesUseCase
        .execute(
          action: sendAction,
        )
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }
}
