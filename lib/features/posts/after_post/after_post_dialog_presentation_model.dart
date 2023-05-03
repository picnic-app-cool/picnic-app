import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/user_contact.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class AfterPostDialogPresentationModel implements AfterPostDialogViewModel {
  /// Creates the initial state
  AfterPostDialogPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    AfterPostDialogInitialParams initialParams,
  )   : permissionStatus = RuntimePermissionStatus.unknown,
        userContacts = const PaginatedList.empty(),
        phoneContacts = [],
        searchQuery = '',
        post = initialParams.post,
        shareLink = initialParams.post.shareLink;

  /// Used for the copyWith method
  AfterPostDialogPresentationModel._({
    required this.permissionStatus,
    required this.userContacts,
    required this.phoneContacts,
    required this.searchQuery,
    required this.post,
    required this.shareLink,
  });

  final RuntimePermissionStatus permissionStatus;

  final Post post;

  final String shareLink;

  @override
  final String searchQuery;

  @override
  final PaginatedList<UserContact> userContacts;

  @override
  final List<PhoneContact> phoneContacts;

  @override
  bool get showContactAccessButton => RuntimePermissionStatus.isDenied(permissionStatus);

  AfterPostDialogPresentationModel byIncrementingShareCount() {
    return copyWith(
      post: post.byIncrementingShareCount(),
    );
  }

  AfterPostDialogPresentationModel byUpdateInviteAction(UserContact contact) => copyWith(
        userContacts: userContacts.byUpdatingItem(
          update: (update) {
            return update.copyWith(invited: !contact.invited);
          },
          itemFinder: (finder) => contact.id == finder.id,
        ),
      );

  AfterPostDialogPresentationModel copyWith({
    RuntimePermissionStatus? permissionStatus,
    PaginatedList<UserContact>? userContacts,
    List<PhoneContact>? phoneContacts,
    String? searchQuery,
    Post? post,
    String? shareLink,
  }) {
    return AfterPostDialogPresentationModel._(
      permissionStatus: permissionStatus ?? this.permissionStatus,
      userContacts: userContacts ?? this.userContacts,
      phoneContacts: phoneContacts ?? this.phoneContacts,
      searchQuery: searchQuery ?? this.searchQuery,
      post: post ?? this.post,
      shareLink: shareLink ?? this.shareLink,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class AfterPostDialogViewModel {
  bool get showContactAccessButton;

  PaginatedList<UserContact> get userContacts;

  List<PhoneContact> get phoneContacts;

  String get searchQuery;
}
