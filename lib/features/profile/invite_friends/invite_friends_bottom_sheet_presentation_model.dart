import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/user_contact.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
// ignore: prefer-correct-type-name
class InviteFriendsBottomSheetPresentationModel implements InviteFriendsBottomSheetViewModel {
  /// Creates the initial state
  InviteFriendsBottomSheetPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    InviteFriendsBottomSheetInitialParams initialParams,
  )   : permissionStatus = RuntimePermissionStatus.unknown,
        shareLink = initialParams.shareLink,
        userContacts = const PaginatedList.empty(),
        phoneContacts = [],
        searchQuery = '';

  /// Used for the copyWith method
  InviteFriendsBottomSheetPresentationModel._({
    required this.permissionStatus,
    required this.userContacts,
    required this.phoneContacts,
    required this.searchQuery,
    required this.shareLink,
  });

  final RuntimePermissionStatus permissionStatus;

  final String shareLink;

  @override
  final PaginatedList<UserContact> userContacts;

  @override
  final List<PhoneContact> phoneContacts;

  @override
  final String searchQuery;

  @override
  bool get showContactAccessButton => RuntimePermissionStatus.isDenied(permissionStatus);

  InviteFriendsBottomSheetPresentationModel byUpdateInviteAction(UserContact contact) => copyWith(
        userContacts: userContacts.byUpdatingItem(
          update: (update) {
            return update.copyWith(invited: !contact.invited);
          },
          itemFinder: (finder) => contact.id == finder.id,
        ),
      );

  InviteFriendsBottomSheetPresentationModel copyWith({
    RuntimePermissionStatus? permissionStatus,
    PaginatedList<UserContact>? userContacts,
    List<PhoneContact>? phoneContacts,
    String? searchQuery,
    String? shareLink,
  }) {
    return InviteFriendsBottomSheetPresentationModel._(
      permissionStatus: permissionStatus ?? this.permissionStatus,
      userContacts: userContacts ?? this.userContacts,
      phoneContacts: phoneContacts ?? this.phoneContacts,
      searchQuery: searchQuery ?? this.searchQuery,
      shareLink: shareLink ?? this.shareLink,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class InviteFriendsBottomSheetViewModel {
  bool get showContactAccessButton;

  PaginatedList<UserContact> get userContacts;

  List<PhoneContact> get phoneContacts;

  String get searchQuery;
}
