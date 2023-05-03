import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/follow_unfollow_user_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/followers/followers_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class FollowersPresentationModel implements FollowersViewModel {
  /// Creates the initial state
  FollowersPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    FollowersInitialParams initialParams,
    UserStore userStore,
  )   : followers = const PaginatedList.empty(),
        privateProfile = userStore.privateProfile,
        userId = initialParams.userId,
        toggleFollowResult = const FutureResult.empty(),
        searchQuery = '';

  /// Used for the copyWith method
  FollowersPresentationModel._({
    required this.toggleFollowResult,
    required this.followers,
    required this.userId,
    required this.privateProfile,
    required this.searchQuery,
  });

  final FutureResult<Either<FollowUnfollowUserFailure, Unit>> toggleFollowResult;

  @override
  final PaginatedList<PublicProfile> followers;

  @override
  final PrivateProfile privateProfile;

  @override
  final Id userId;

  @override
  final String searchQuery;

  @override
  bool get isLoadingToggleFollow => toggleFollowResult.isPending();

  Cursor get cursor => followers.nextPageCursor();

  FollowersPresentationModel byUpdateFollowAction(PublicProfile follower) => copyWith(
        followers: followers.byUpdatingItem(
          update: (update) {
            return update.copyWith(iFollow: !update.iFollow);
          },
          itemFinder: (finder) => follower.id == finder.id,
        ),
      );

  FollowersPresentationModel byAppendingFollowersList({
    required PaginatedList<PublicProfile> newList,
  }) =>
      copyWith(
        followers: followers + newList,
      );

  FollowersPresentationModel copyWith({
    FutureResult<Either<FollowUnfollowUserFailure, Unit>>? toggleFollowResult,
    PaginatedList<PublicProfile>? followers,
    Id? userId,
    String? searchQuery,
    PrivateProfile? privateProfile,
  }) {
    return FollowersPresentationModel._(
      toggleFollowResult: toggleFollowResult ?? this.toggleFollowResult,
      userId: userId ?? this.userId,
      followers: followers ?? this.followers,
      searchQuery: searchQuery ?? this.searchQuery,
      privateProfile: privateProfile ?? this.privateProfile,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class FollowersViewModel {
  bool get isLoadingToggleFollow;

  PaginatedList<PublicProfile> get followers;

  PrivateProfile get privateProfile;

  Id get userId;

  String get searchQuery;
}
