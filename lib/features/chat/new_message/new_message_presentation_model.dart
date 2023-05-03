import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/new_message/new_message_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class NewMessagePresentationModel implements NewMessageViewModel {
  /// Creates the initial state
  NewMessagePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    NewMessageInitialParams initialParams,
    UserStore userStore,
  )   : groupName = "",
        newMessageText = "",
        searchText = "",
        createChatResult = const FutureResult.empty(),
        resizeToAvoidBottomInset = true,
        recipients = initialParams.user == const User.empty() ? List.empty() : [initialParams.user],
        users = const PaginatedList.empty(),
        privateProfile = userStore.privateProfile,
        selectedAttachments = const [],
        isMediaPickerVisible = false;

  /// Used for the copyWith method
  NewMessagePresentationModel._({
    required this.groupName,
    required this.newMessageText,
    required this.searchText,
    required this.createChatResult,
    required this.resizeToAvoidBottomInset,
    required this.recipients,
    required this.users,
    required this.privateProfile,
    required this.selectedAttachments,
    required this.isMediaPickerVisible,
  });

  @override
  final String groupName;

  @override
  final String newMessageText;

  final String searchText;

  final FutureResult<void> createChatResult;

  @override
  final bool resizeToAvoidBottomInset;

  final PrivateProfile privateProfile;

  @override
  final List<User> recipients;

  @override
  final List<Attachment> selectedAttachments;

  @override
  final PaginatedList<Selectable<User>> users;

  @override
  final bool isMediaPickerVisible;

  Cursor get usersCursor => users.nextPageCursor();

  List<Id> get userIds => List.unmodifiable([privateProfile.id] + recipients.map((it) => it.id).toList());

  @override
  bool get isGroup {
    const minimumGroupSize = 2;
    return recipients.length >= minimumGroupSize;
  }

  @override
  bool get sendMessageEnabled {
    return (selectedAttachments.isNotEmpty || newMessageText.trim().isNotEmpty) &&
        recipients.isNotEmpty &&
        createChatResult.status != FutureStatus.pending;
  }

  @override
  bool get showRecipients => recipients.isNotEmpty;

  String get formattedGroupName => groupName.isEmpty ? recipients.map((it) => it.username).join(', ') : groupName;

  //TODO GS-1870,GS-1871: For now its only chat message with text type, in the future we are going to support other types
  ChatMessage get chatMessage => const ChatMessage.empty().copyWith(
        content: newMessageText,
        chatMessageType: ChatMessageType.text,
      );

  NewMessagePresentationModel byAppendingFriendsList(PaginatedList<Selectable<User>> newList) => copyWith(
        users: users + newList,
      );

  NewMessagePresentationModel byTogglingMediaPickerVisibility() => copyWith(
        isMediaPickerVisible: !isMediaPickerVisible,
      );

  NewMessagePresentationModel copyWith({
    String? groupName,
    String? newMessageText,
    String? searchText,
    FutureResult<void>? createChatResult,
    bool? resizeToAvoidBottomInset,
    List<User>? recipients,
    PaginatedList<Selectable<User>>? users,
    PrivateProfile? privateProfile,
    List<Attachment>? selectedAttachments,
    bool? isMediaPickerVisible,
  }) {
    return NewMessagePresentationModel._(
      newMessageText: newMessageText ?? this.newMessageText,
      groupName: groupName ?? this.groupName,
      searchText: searchText ?? this.searchText,
      createChatResult: createChatResult ?? this.createChatResult,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? this.resizeToAvoidBottomInset,
      recipients: recipients ?? this.recipients,
      users: users ?? this.users,
      privateProfile: privateProfile ?? this.privateProfile,
      selectedAttachments: selectedAttachments ?? this.selectedAttachments,
      isMediaPickerVisible: isMediaPickerVisible ?? this.isMediaPickerVisible,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class NewMessageViewModel {
  PaginatedList<Selectable<User>> get users;

  bool get sendMessageEnabled;

  bool get isGroup;

  bool get showRecipients;

  List<User> get recipients;

  bool get resizeToAvoidBottomInset;

  List<Attachment> get selectedAttachments;

  bool get isMediaPickerVisible;

  String get groupName;

  String get newMessageText;
}
