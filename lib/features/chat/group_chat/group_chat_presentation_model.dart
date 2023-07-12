import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_post_payload.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class GroupChatPresentationModel extends GroupChatViewModel {
  /// Creates the initial state
  GroupChatPresentationModel.initial(
    GroupChatInitialParams initialParams,
    FeatureFlagsStore featureFlagStore,
    UserStore userStore,
    this.currentTimeProvider,
  )   : chat = initialParams.chat,
        //TODO GS-2115: Get online counts when BE will be ready
        onlineCount = 0,
        displayableMessages = const PaginatedList.empty(),
        selectedMessage = const ChatMessage.empty(),
        replyMessage = const Selectable<ChatMessage>(item: ChatMessage.empty()),
        pendingMessage = const ChatMessage.empty(),
        featureFlags = featureFlagStore.featureFlags,
        dragOffset = 0,
        members = const PaginatedList.empty(),
        privateProfile = userStore.privateProfile,
        isMediaPickerVisible = false,
        clearSelectedMediaAttachment = false,
        suggestedUsersToMention = const PaginatedList.empty(),
        usersToMention = const PaginatedList.empty();

  /// Used for the copyWith method
  GroupChatPresentationModel._({
    required this.onlineCount,
    required this.selectedMessage,
    required this.replyMessage,
    required this.displayableMessages,
    required this.pendingMessage,
    required this.chat,
    required this.featureFlags,
    required this.members,
    required this.privateProfile,
    required this.dragOffset,
    required this.currentTimeProvider,
    required this.isMediaPickerVisible,
    required this.clearSelectedMediaAttachment,
    required this.suggestedUsersToMention,
    required this.usersToMention,
  });

  final CurrentTimeProvider currentTimeProvider;

  final BasicChat chat;

  final FeatureFlags featureFlags;

  final PrivateProfile privateProfile;

  @override
  final ChatMessage pendingMessage;

  @override
  final ChatMessage selectedMessage;

  @override
  final PaginatedList<DisplayableChatMessage> displayableMessages;

  @override
  final Selectable<ChatMessage> replyMessage;

  @override
  final int onlineCount;

  @override
  final double dragOffset;

  @override
  final PaginatedList<ChatMember> members;

  @override
  final PaginatedList<UserMention> suggestedUsersToMention;

  @override
  final PaginatedList<UserMention> usersToMention;

  @override
  final bool isMediaPickerVisible;

  @override
  final bool clearSelectedMediaAttachment;

  Cursor get membersCursor => members.nextPageCursor();

  @override
  int get membersCount => chat.participantsCount;

  @override
  String get groupName => chat.name;

  @override
  bool get sendMessageEnabled => !pendingMessage.isEmptyMessage;

  @override
  bool get isChatInputAttachmentEnabled => featureFlags[FeatureFlagType.chatInputAttachmentEnabled];

  @override
  bool get isChatInputElectricEnabled => featureFlags[FeatureFlagType.chatInputElectricEnabled];

  @override
  bool get isChatSettingOnlineUsersEnabled => featureFlags[FeatureFlagType.chatSettingOnlineUsersEnabled];

  @override
  bool get isChatInputAttachmentNativePickerEnabled => featureFlags[FeatureFlagType.attachmentNativePicker];

  @override
  DateTime get now => currentTimeProvider.currentTime;

  bool get isMentionUserEnabled => featureFlags[FeatureFlagType.mentionUserInChatEnabled];

  GroupChatViewModel byUpdatingSelectedMessage({ChatMessage? selectedMessage}) => copyWith(
        selectedMessage: selectedMessage,
      );

  GroupChatViewModel byUpdatingReplyMessage({Selectable<ChatMessage>? replyMessage}) => copyWith(
        replyMessage: replyMessage,
      );

  GroupChatViewModel byUpdatingDisplayableMessages({PaginatedList<DisplayableChatMessage>? displayableMessages}) =>
      copyWith(
        displayableMessages: displayableMessages,
      );

  GroupChatViewModel byUpdatingPendingMessage({ChatMessage? pendingMessage}) => copyWith(
        pendingMessage: pendingMessage,
      );

  GroupChatViewModel byTogglingMediaPickerVisibility({bool clearSelectedMediaAttachment = false}) => copyWith(
        isMediaPickerVisible: !isMediaPickerVisible,
        clearSelectedMediaAttachment: clearSelectedMediaAttachment,
      );

  GroupChatViewModel byUpdatingPostInChatMessage({
    required Post post,
    required ChatMessage chatMessage,
  }) {
    return copyWith(
      displayableMessages: displayableMessages.byUpdatingItem(
        update: (displayableMessage) {
          final component = displayableMessage.chatMessage.component;
          final payload = component?.payload;
          if (payload is ChatMessagePostPayload) {
            return displayableMessage.copyWith(
              chatMessage: displayableMessage.chatMessage.copyWith(
                component: component?.copyWith(
                  payload: payload.copyWith(post: post),
                ),
              ),
            );
          }
          return displayableMessage;
        },
        itemFinder: (displayableChatMessage) => displayableChatMessage.chatMessage.id == chatMessage.id,
      ),
    );
  }

  GroupChatPresentationModel copyWith({
    CurrentTimeProvider? currentTimeProvider,
    ChatMessage? pendingMessage,
    BasicChat? chat,
    FeatureFlags? featureFlags,
    ChatMessage? selectedMessage,
    PaginatedList<DisplayableChatMessage>? displayableMessages,
    Selectable<ChatMessage>? replyMessage,
    int? onlineCount,
    double? dragOffset,
    PaginatedList<ChatMember>? members,
    PrivateProfile? privateProfile,
    bool? isMediaPickerVisible,
    PaginatedList<UserMention>? suggestedUsersToMention,
    PaginatedList<UserMention>? usersToMention,
    bool? clearSelectedMediaAttachment,
  }) {
    return GroupChatPresentationModel._(
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      pendingMessage: pendingMessage ?? this.pendingMessage,
      chat: chat ?? this.chat,
      featureFlags: featureFlags ?? this.featureFlags,
      selectedMessage: selectedMessage ?? this.selectedMessage,
      displayableMessages: displayableMessages ?? this.displayableMessages,
      replyMessage: replyMessage ?? this.replyMessage,
      onlineCount: onlineCount ?? this.onlineCount,
      dragOffset: dragOffset ?? this.dragOffset,
      members: members ?? this.members,
      privateProfile: privateProfile ?? this.privateProfile,
      isMediaPickerVisible: isMediaPickerVisible ?? this.isMediaPickerVisible,
      clearSelectedMediaAttachment: clearSelectedMediaAttachment ?? this.clearSelectedMediaAttachment,
      suggestedUsersToMention: suggestedUsersToMention ?? this.suggestedUsersToMention,
      usersToMention: usersToMention ?? this.usersToMention,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class GroupChatViewModel {
  PaginatedList<DisplayableChatMessage> get displayableMessages;

  ChatMessage get selectedMessage;

  ChatMessage get pendingMessage;

  Selectable<ChatMessage> get replyMessage;

  String get groupName;

  int get membersCount;

  int get onlineCount;

  bool get sendMessageEnabled;

  bool get isChatInputAttachmentEnabled;

  bool get isChatInputElectricEnabled;

  bool get isChatSettingOnlineUsersEnabled;

  bool get isChatInputAttachmentNativePickerEnabled;

  double get dragOffset;

  PaginatedList<ChatMember> get members;

  DateTime get now;

  bool get isMediaPickerVisible;

  bool get clearSelectedMediaAttachment;

  PaginatedList<UserMention> get suggestedUsersToMention;

  PaginatedList<UserMention> get usersToMention;
}
