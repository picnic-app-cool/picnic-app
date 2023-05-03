import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleChatPresentationModel implements CircleChatViewModel {
  /// Creates the initial state
  CircleChatPresentationModel.initial(
    CircleChatInitialParams initialParams,
    FeatureFlagsStore featureFlagStore,
    this.currentTimeProvider,
  )   : displayableMessages = const PaginatedList.empty(),
        selectedMessage = const ChatMessage.empty(),
        replyMessage = const Selectable<ChatMessage>(item: ChatMessage.empty()),
        chat = initialParams.chat,
        pendingMessage = const ChatMessage.empty(),
        featureFlags = featureFlagStore.featureFlags,
        dragOffset = 0,
        isMediaPickerVisible = false,
        clearSelectedMediaAttachment = false;

  /// Used for the copyWith method
  CircleChatPresentationModel._({
    required this.displayableMessages,
    required this.selectedMessage,
    required this.replyMessage,
    required this.pendingMessage,
    required this.chat,
    required this.currentTimeProvider,
    required this.featureFlags,
    required this.dragOffset,
    required this.isMediaPickerVisible,
    required this.clearSelectedMediaAttachment,
  });

  final CurrentTimeProvider currentTimeProvider;

  final Chat chat;

  final FeatureFlags featureFlags;

  @override
  final ChatMessage pendingMessage;

  @override
  final ChatMessage selectedMessage;

  @override
  final PaginatedList<DisplayableChatMessage> displayableMessages;

  @override
  final Selectable<ChatMessage> replyMessage;

  @override
  final double dragOffset;

  @override
  final bool isMediaPickerVisible;

  @override
  final bool clearSelectedMediaAttachment;

  @override
  DateTime get now => currentTimeProvider.currentTime;

  BasicCircle get circle => chat.circle;

  @override
  int get membersCount => circle.membersCount;

  @override
  String get name => circle.name;

  @override
  String get emoji => circle.emoji;

  @override
  String get image => circle.imageFile;

  @override
  bool get sendMessageEnabled => !pendingMessage.isEmptyMessage;

  @override
  bool get isChatInputAttachmentEnabled => featureFlags[FeatureFlagType.chatInputAttachmentEnabled];

  @override
  bool get isChatInputElectricEnabled => featureFlags[FeatureFlagType.chatInputElectricEnabled];

  @override
  bool get isChatInputAttachmentNativePickerEnabled => featureFlags[FeatureFlagType.attachmentNativePicker];

  @override
  bool get isChatInputBarVisible => !circle.isBanned;

  @override
  bool get isUserBanned => circle.isBanned;

  @override
  bool get chatEnabled => circle.chatEnabled && circle.hasPermissionToChat;

  @override
  bool get hasPermissionToChat => circle.hasPermissionToChat;

  @override
  bool get hasPermissionToAddAttachments => circle.permissions.canAttachFiles;

  bool get isDeleteMultipleMessagesEnabled => featureFlags[FeatureFlagType.circleDeleteMultipleMessagesEnabled];

  CircleChatViewModel byUpdatingSelectedMessage({ChatMessage? selectedMessage}) => copyWith(
        selectedMessage: selectedMessage,
      );

  CircleChatViewModel byUpdatingReplyMessage({Selectable<ChatMessage>? replyMessage}) => copyWith(
        replyMessage: replyMessage,
      );

  CircleChatViewModel byUpdatingDisplayableMessages({PaginatedList<DisplayableChatMessage>? displayableMessages}) =>
      copyWith(
        displayableMessages: displayableMessages,
      );

  CircleChatViewModel byUpdatingPendingMessage({ChatMessage? pendingMessage}) => copyWith(
        pendingMessage: pendingMessage,
      );

  CircleChatViewModel byTogglingMediaPickerVisibility({bool clearSelectedMediaAttachment = false}) => copyWith(
        isMediaPickerVisible: !isMediaPickerVisible,
        clearSelectedMediaAttachment: clearSelectedMediaAttachment,
      );

  CircleChatPresentationModel copyWith({
    CurrentTimeProvider? currentTimeProvider,
    Chat? chat,
    FeatureFlags? featureFlags,
    ChatMessage? pendingMessage,
    ChatMessage? selectedMessage,
    PaginatedList<DisplayableChatMessage>? displayableMessages,
    Selectable<ChatMessage>? replyMessage,
    double? dragOffset,
    bool? isMediaPickerVisible,
    bool? clearSelectedMediaAttachment,
  }) {
    return CircleChatPresentationModel._(
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      chat: chat ?? this.chat,
      featureFlags: featureFlags ?? this.featureFlags,
      pendingMessage: pendingMessage ?? this.pendingMessage,
      selectedMessage: selectedMessage ?? this.selectedMessage,
      displayableMessages: displayableMessages ?? this.displayableMessages,
      replyMessage: replyMessage ?? this.replyMessage,
      dragOffset: dragOffset ?? this.dragOffset,
      isMediaPickerVisible: isMediaPickerVisible ?? this.isMediaPickerVisible,
      clearSelectedMediaAttachment: clearSelectedMediaAttachment ?? this.clearSelectedMediaAttachment,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleChatViewModel {
  PaginatedList<DisplayableChatMessage> get displayableMessages;

  ChatMessage get selectedMessage;

  ChatMessage get pendingMessage;

  Selectable<ChatMessage> get replyMessage;

  int get membersCount;

  String get name;

  String get emoji;

  String get image;

  DateTime get now;

  bool get sendMessageEnabled;

  bool get isChatInputAttachmentEnabled;

  bool get isChatInputElectricEnabled;

  bool get isChatInputAttachmentNativePickerEnabled;

  double get dragOffset;

  bool get isChatInputBarVisible;

  bool get isUserBanned;

  bool get isMediaPickerVisible;

  bool get clearSelectedMediaAttachment;

  bool get chatEnabled;

  bool get hasPermissionToChat;

  bool get hasPermissionToAddAttachments;
}
