import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/get_user_contact_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/user_contact.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/circles/domain/model/search_non_member_users_failure.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleCreationSuccessPresentationModel implements CircleCreationSuccessViewModel {
  /// Creates the initial state
  CircleCreationSuccessPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleCreationSuccessInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : createPostInput = initialParams.createPostInput,
        query = '',
        circle = initialParams.circle,
        contactsResult = const FutureResult.empty(),
        userContacts = const PaginatedList.empty(),
        phoneContacts = [],
        permissionStatus = RuntimePermissionStatus.unknown,
        featureFlags = featureFlagsStore.featureFlags,
        createCircleWithoutPost = initialParams.createCircleWithoutPost;

  /// Used for the copyWith method
  CircleCreationSuccessPresentationModel._({
    required this.createPostInput,
    required this.circle,
    required this.featureFlags,
    required this.query,
    required this.userContacts,
    required this.phoneContacts,
    required this.permissionStatus,
    required this.contactsResult,
    required this.createCircleWithoutPost,
  });

  @override
  final Circle circle;
  final CreatePostInput createPostInput;
  final FeatureFlags featureFlags;
  final String query;
  final RuntimePermissionStatus permissionStatus;

  final FutureResult<Either<GetUserContactFailure, PaginatedList<UserContact>>> contactsResult;

  @override
  final PaginatedList<UserContact> userContacts;

  @override
  final List<PhoneContact> phoneContacts;

  @override
  final bool createCircleWithoutPost;

  @override
  bool get showContactAccessButton => RuntimePermissionStatus.isDenied(permissionStatus);

  @override
  bool get showSeeds => featureFlags[FeatureFlagType.areSeedsEnabled];

  @override
  bool get isLoading => contactsResult.isPending();

  @override
  bool get enableContactSharing => featureFlags[FeatureFlagType.phoneContactsSharingEnable];

  @override
  String get circleShareLink => circle.inviteCircleLink;

  CircleCreationSuccessPresentationModel byUpdateInviteAction(UserContact contact) => copyWith(
        userContacts: userContacts.byUpdatingItem(
          update: (update) {
            return update.copyWith(invited: !contact.invited);
          },
          itemFinder: (finder) => contact.id == finder.id,
        ),
      );

  CircleCreationSuccessPresentationModel copyWith({
    Circle? circle,
    String? query,
    PaginatedList<UserContact>? userContacts,
    List<PhoneContact>? phoneContacts,
    CreatePostInput? createPostInput,
    FeatureFlags? featureFlags,
    RuntimePermissionStatus? permissionStatus,
    FutureResult<Either<SearchNonMemberUsersFailure, PaginatedList<PublicProfile>>>? nonMembersResult,
    FutureResult<Either<GetUserContactFailure, PaginatedList<UserContact>>>? contactsResult,
    bool? createCircleWithoutPost,
  }) {
    return CircleCreationSuccessPresentationModel._(
      query: query ?? this.query,
      circle: circle ?? this.circle,
      createPostInput: createPostInput ?? this.createPostInput,
      featureFlags: featureFlags ?? this.featureFlags,
      userContacts: userContacts ?? this.userContacts,
      phoneContacts: phoneContacts ?? this.phoneContacts,
      permissionStatus: permissionStatus ?? this.permissionStatus,
      contactsResult: contactsResult ?? this.contactsResult,
      createCircleWithoutPost: createCircleWithoutPost ?? this.createCircleWithoutPost,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleCreationSuccessViewModel {
  Circle get circle;

  String get circleShareLink;

  PaginatedList<UserContact> get userContacts;

  List<PhoneContact> get phoneContacts;

  bool get showSeeds;

  bool get isLoading;

  bool get showContactAccessButton;

  bool get enableContactSharing;

  bool get createCircleWithoutPost;
}
