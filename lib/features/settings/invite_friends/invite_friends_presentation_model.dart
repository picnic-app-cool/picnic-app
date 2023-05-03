import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/user_contact.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class InviteFriendsPresentationModel implements InviteFriendsViewModel {
  /// Creates the initial state
  InviteFriendsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    InviteFriendsInitialParams initialParams,
  )   : permissionStatus = RuntimePermissionStatus.unknown,
        userContacts = const PaginatedList.empty(),
        phoneContacts = [],
        searchQuery = '',
        link = initialParams.inviteLink;

  /// Used for the copyWith method
  InviteFriendsPresentationModel._({
    required this.permissionStatus,
    required this.link,
    required this.userContacts,
    required this.phoneContacts,
    required this.searchQuery,
  });

  @override
  final PaginatedList<UserContact> userContacts;

  @override
  final List<PhoneContact> phoneContacts;

  @override
  final String searchQuery;

  final RuntimePermissionStatus permissionStatus;

  final String link;

  @override
  bool get showContactAccessButton => RuntimePermissionStatus.isDenied(permissionStatus);

  InviteFriendsPresentationModel byUpdateInviteAction(UserContact contact) => copyWith(
        userContacts: userContacts.byUpdatingItem(
          update: (update) {
            return update.copyWith(invited: !contact.invited);
          },
          itemFinder: (finder) => contact.id == finder.id,
        ),
      );

  InviteFriendsPresentationModel copyWith({
    RuntimePermissionStatus? permissionStatus,
    String? link,
    PaginatedList<UserContact>? userContacts,
    List<PhoneContact>? phoneContacts,
    String? searchQuery,
  }) {
    return InviteFriendsPresentationModel._(
      permissionStatus: permissionStatus ?? this.permissionStatus,
      link: link ?? this.link,
      userContacts: userContacts ?? this.userContacts,
      phoneContacts: phoneContacts ?? this.phoneContacts,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class InviteFriendsViewModel {
  bool get showContactAccessButton;

  PaginatedList<UserContact> get userContacts;

  List<PhoneContact> get phoneContacts;

  String get searchQuery;
}
