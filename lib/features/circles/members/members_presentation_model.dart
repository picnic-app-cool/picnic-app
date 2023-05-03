import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/follow_unfollow_user_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_members_failure.dart';
import 'package:picnic_app/features/circles/members/members_initial_params.dart';

class MembersPresentationModel implements MembersPageViewModel {
  MembersPresentationModel.initial(
    MembersInitialParams initialParams,
    UserStore userStore,
    FeatureFlagsStore featureFlagsStore,
  )   : members = const PaginatedList.empty(),
        directors = const PaginatedList.empty(),
        toggleFollowResult = const FutureResult.empty(),
        featureFlags = featureFlagsStore.featureFlags,
        privateProfile = userStore.privateProfile,
        circle = initialParams.circle,
        searchQuery = '',
        membersSearchOperation = null;

  MembersPresentationModel._({
    required this.toggleFollowResult,
    required this.members,
    required this.circle,
    required this.privateProfile,
    required this.searchQuery,
    required this.directors,
    required this.membersSearchOperation,
    required this.featureFlags,
  });

  final FutureResult<Either<FollowUnfollowUserFailure, Unit>> toggleFollowResult;
  final FeatureFlags featureFlags;

  @override
  final PaginatedList<CircleMember> members;

  @override
  final PaginatedList<CircleMember> directors;

  @override
  final PrivateProfile privateProfile;

  @override
  final Circle circle;

  @override
  final String searchQuery;

  final CancelableOperation<Either<GetCircleMembersFailure, PaginatedList<PublicProfile>>>? membersSearchOperation;

  @override
  bool get isLoadingToggleFollow => toggleFollowResult.isPending();

  Cursor get membersCursor => members.nextPageCursor();

  Cursor get directorsCursor => directors.nextPageCursor();

  MembersPresentationModel byAppendingMembersList(PaginatedList<CircleMember> newList) => copyWith(
        members: members + newList,
      );

  MembersPresentationModel byUpdateFollowAction(CircleMember member) => copyWith(
        members: members.byUpdatingItem(
          update: (update) => update.copyWith(user: update.user.copyWith(iFollow: !update.user.iFollow)),
          itemFinder: (finder) => member.user.id == finder.user.id,
        ),
      );

  MembersPresentationModel byAppendingDirectorsList(
    PaginatedList<CircleMember> newList,
  ) =>
      copyWith(
        directors: directors + newList,
      );

  MembersPresentationModel copyWith({
    PaginatedList<CircleMember>? members,
    PaginatedList<CircleMember>? directors,
    FutureResult<Either<FollowUnfollowUserFailure, Unit>>? toggleFollowResult,
    Circle? circle,
    String? searchQuery,
    PrivateProfile? privateProfile,
    CancelableOperation<Either<GetCircleMembersFailure, PaginatedList<PublicProfile>>>? membersSearchOperation,
    FeatureFlags? featureFlags,
  }) {
    return MembersPresentationModel._(
      toggleFollowResult: toggleFollowResult ?? this.toggleFollowResult,
      circle: circle ?? this.circle,
      members: members ?? this.members,
      searchQuery: searchQuery ?? this.searchQuery,
      privateProfile: privateProfile ?? this.privateProfile,
      directors: directors ?? this.directors,
      membersSearchOperation: membersSearchOperation ?? this.membersSearchOperation,
      featureFlags: featureFlags ?? this.featureFlags,
    );
  }
}

abstract class MembersPageViewModel {
  PaginatedList<CircleMember> get members;

  PaginatedList<CircleMember> get directors;

  bool get isLoadingToggleFollow;

  PrivateProfile get privateProfile;

  Circle get circle;

  String get searchQuery;
}
