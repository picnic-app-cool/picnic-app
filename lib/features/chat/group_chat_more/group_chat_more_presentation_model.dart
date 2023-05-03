import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_role.dart';
import 'package:picnic_app/features/chat/domain/model/chat_settings.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_members_failure.dart';
import 'package:picnic_app/features/chat/domain/model/group_chat_more_tab.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class GroupChatMorePresentationModel implements GroupChatMoreViewModel {
  /// Creates the initial state
  GroupChatMorePresentationModel.initial(
    GroupChatMoreInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
    UserStore userStore,
  )   : chat = initialParams.chat,
        onChatChanged = initialParams.onChatChanged,
        featureFlags = featureFlagsStore.featureFlags,
        selectedTab = GroupChatMoreTab.settings,
        members = const PaginatedList.empty(),
        chatSettings = const ChatSettings.empty(),
        privateProfile = userStore.privateProfile,
        getChatMembersOperation = null;

  /// Used for the copyWith method
  GroupChatMorePresentationModel._({
    required this.chat,
    required this.onChatChanged,
    required this.featureFlags,
    required this.selectedTab,
    required this.members,
    required this.chatSettings,
    required this.privateProfile,
    required this.getChatMembersOperation,
  });

  final PrivateProfile privateProfile;

  final BasicChat chat;

  final ValueChanged<BasicChat>? onChatChanged;

  final FeatureFlags featureFlags;

  final CancelableOperation<Either<GetChatMembersFailure, PaginatedList<ChatMember>>>? getChatMembersOperation;

  @override
  final ChatSettings chatSettings;

  @override
  final GroupChatMoreTab selectedTab;

  @override
  final PaginatedList<ChatMember> members;

  Cursor get cursor => members.nextPageCursor();

  @override
  String get groupName => chat.name;

  @override
  int get membersCount => chat.participantsCount;

  @override
  int get onlineCount => 0;

  @override
  bool get isAddMembersVisible => selectedTab == GroupChatMoreTab.members;

  @override
  bool get isRemoveUsersEnabled =>
      members.items.isEmpty ||
      members.items.firstWhere(
            (it) => it.role == ChatRole.director && it.userId == privateProfile.id,
            orElse: () => const ChatMember.empty(),
          ) !=
          const ChatMember.empty();

  GroupChatMorePresentationModel byAppendingMembersList(PaginatedList<ChatMember> newList) => copyWith(
        members: members + newList,
      );

  GroupChatMorePresentationModel byClearingChatMembersList() => copyWith(
        members: const PaginatedList.empty(),
      );

  GroupChatMorePresentationModel byRemovingMember(ChatMember member) => copyWith(
        members: members.byRemoving(element: member),
      );

  GroupChatMorePresentationModel copyWith({
    PrivateProfile? privateProfile,
    BasicChat? chat,
    ValueChanged<BasicChat>? onChatChanged,
    FeatureFlags? featureFlags,
    ChatSettings? chatSettings,
    GroupChatMoreTab? selectedTab,
    PaginatedList<ChatMember>? members,
    CancelableOperation<Either<GetChatMembersFailure, PaginatedList<ChatMember>>>? getChatMembersOperation,
  }) {
    return GroupChatMorePresentationModel._(
      privateProfile: privateProfile ?? this.privateProfile,
      chat: chat ?? this.chat,
      onChatChanged: onChatChanged ?? this.onChatChanged,
      featureFlags: featureFlags ?? this.featureFlags,
      chatSettings: chatSettings ?? this.chatSettings,
      selectedTab: selectedTab ?? this.selectedTab,
      members: members ?? this.members,
      getChatMembersOperation: getChatMembersOperation ?? this.getChatMembersOperation,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class GroupChatMoreViewModel {
  String get groupName;

  int get membersCount;

  int get onlineCount;

  GroupChatMoreTab get selectedTab;

  PaginatedList<ChatMember> get members;

  bool get isAddMembersVisible;

  bool get isRemoveUsersEnabled;

  ChatSettings get chatSettings;
}
