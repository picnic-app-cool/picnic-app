import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_circle_invite.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SingleChatPresentationModel implements SingleChatViewModel {
  /// Creates the initial state
  SingleChatPresentationModel.initial(
    SingleChatInitialParams initialParams,
    FeatureFlagsStore featureFlagStore,
    this.userStore,
    this.currentTimeProvider,
  )   : displayableMessages = const PaginatedList.empty(),
        selectedMessage = const ChatMessage.empty(),
        replyMessage = const Selectable<ChatMessage>(item: ChatMessage.empty()),
        chat = initialParams.chat,
        recipientUser = const User.empty(),
        pendingMessage = const ChatMessage.empty(),
        featureFlags = featureFlagStore.featureFlags,
        dragOffset = 0,
        isMediaPickerVisible = false,
        clearSelectedMediaAttachment = false,
        attachments = const PaginatedList.empty();

  /// Used for the copyWith method
  SingleChatPresentationModel._({
    required this.displayableMessages,
    required this.selectedMessage,
    required this.replyMessage,
    required this.pendingMessage,
    required this.recipientUser,
    required this.chat,
    required this.currentTimeProvider,
    required this.featureFlags,
    required this.dragOffset,
    required this.userStore,
    required this.isMediaPickerVisible,
    required this.clearSelectedMediaAttachment,
    required this.attachments,
  });

  @override
  final ChatMessage pendingMessage;

  @override
  final ChatMessage selectedMessage;

  final BasicChat chat;

  final UserStore userStore;

  final FeatureFlags featureFlags;

  final CurrentTimeProvider currentTimeProvider;

  @override
  final PaginatedList<DisplayableChatMessage> displayableMessages;

  @override
  final Selectable<ChatMessage> replyMessage;

  @override
  final User recipientUser;

  @override
  final double dragOffset;

  @override
  final bool isMediaPickerVisible;

  @override
  final bool clearSelectedMediaAttachment;

  @override
  final PaginatedList<Attachment> attachments;

  Cursor get cursor => attachments.nextPageCursor(pageSize: Cursor.extendedPageSize);

  @override
  DateTime get now => currentTimeProvider.currentTime;

  @override
  bool get sendMessageEnabled => !pendingMessage.isEmptyMessage;

  @override
  bool get isChatInputAttachmentEnabled => featureFlags[FeatureFlagType.chatInputAttachmentEnabled];

  @override
  bool get isChatInputElectricEnabled => featureFlags[FeatureFlagType.chatInputElectricEnabled];

  @override
  bool get isChatInputAttachmentNativePickerEnabled => featureFlags[FeatureFlagType.attachmentNativePicker];

  SingleChatViewModel byUpdatingSelectedMessage({ChatMessage? selectedMessage}) => copyWith(
        selectedMessage: selectedMessage,
      );

  SingleChatViewModel byUpdatingReplyMessage({Selectable<ChatMessage>? replyMessage}) => copyWith(
        replyMessage: replyMessage,
      );

  SingleChatViewModel byUpdatingDisplayableMessages({PaginatedList<DisplayableChatMessage>? displayableMessages}) {
    return copyWith(
      displayableMessages: displayableMessages,
    );
  }

  SingleChatViewModel byUpdatingPendingMessage({ChatMessage? pendingMessage}) => copyWith(
        pendingMessage: pendingMessage,
      );

  SingleChatViewModel byUpdatingJoinCircle({
    required ChatMessage joinMessage,
    required bool isJoined,
  }) {
    final items = displayableMessages.items;

    final updatedDisplayableMessages = displayableMessages.copyWith(
      items: items.map((item) {
        if (item.chatMessage.id == joinMessage.id) {
          final itemMessage = item.chatMessage;
          final itemMessageComponentPayload = itemMessage.component!.payload as ChatCircleInvite;

          final updatedItemMessage = itemMessage.copyWith(
            component: itemMessage.component?.copyWith(
              payload: itemMessageComponentPayload.copyWith(
                circle: itemMessageComponentPayload.circle.copyWith(iJoined: isJoined),
              ),
            ),
          );

          return item.copyWith(chatMessage: updatedItemMessage);
        }

        return item;
      }).toList(),
    );

    return copyWith(displayableMessages: updatedDisplayableMessages);
  }

  SingleChatViewModel byTogglingMediaPickerVisibility({bool clearSelectedMediaAttachment = false}) => copyWith(
        isMediaPickerVisible: !isMediaPickerVisible,
        clearSelectedMediaAttachment: clearSelectedMediaAttachment,
      );

  SingleChatPresentationModel copyWith({
    ChatMessage? pendingMessage,
    ChatMessage? selectedMessage,
    BasicChat? chat,
    UserStore? userStore,
    FeatureFlags? featureFlags,
    CurrentTimeProvider? currentTimeProvider,
    PaginatedList<DisplayableChatMessage>? displayableMessages,
    Selectable<ChatMessage>? replyMessage,
    User? recipientUser,
    double? dragOffset,
    bool? isMediaPickerVisible,
    bool? clearSelectedMediaAttachment,
    PaginatedList<Attachment>? attachments,
  }) {
    return SingleChatPresentationModel._(
      pendingMessage: pendingMessage ?? this.pendingMessage,
      selectedMessage: selectedMessage ?? this.selectedMessage,
      chat: chat ?? this.chat,
      userStore: userStore ?? this.userStore,
      featureFlags: featureFlags ?? this.featureFlags,
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      displayableMessages: displayableMessages ?? this.displayableMessages,
      replyMessage: replyMessage ?? this.replyMessage,
      recipientUser: recipientUser ?? this.recipientUser,
      dragOffset: dragOffset ?? this.dragOffset,
      isMediaPickerVisible: isMediaPickerVisible ?? this.isMediaPickerVisible,
      clearSelectedMediaAttachment: clearSelectedMediaAttachment ?? this.clearSelectedMediaAttachment,
      attachments: attachments ?? this.attachments,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SingleChatViewModel {
  PaginatedList<DisplayableChatMessage> get displayableMessages;

  ChatMessage get selectedMessage;

  ChatMessage get pendingMessage;

  Selectable<ChatMessage> get replyMessage;

  bool get sendMessageEnabled;

  User get recipientUser;

  DateTime get now;

  bool get isChatInputAttachmentEnabled;

  bool get isChatInputElectricEnabled;

  bool get isChatInputAttachmentNativePickerEnabled;

  double get dragOffset;

  bool get isMediaPickerVisible;

  bool get clearSelectedMediaAttachment;

  PaginatedList<Attachment> get attachments;
}
