import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/get_collections_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_circles_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/get_posts_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/model/get_private_profile_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_profile_stats_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_saved_posts_failure.dart';
import 'package:picnic_app/features/profile/domain/model/unread_notifications_count.dart';
import 'package:picnic_app/features/profile/domain/private_profile_tab.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';
import 'package:picnic_app/features/seeds/domain/model/get_user_seeds_total_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PrivateProfilePresentationModel implements PrivateProfileViewModel {
  /// Creates the initial state
  PrivateProfilePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PrivateProfileInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
    UserStore userStore,
  )   : selectedTab = PrivateProfileTab.posts,
        posts = const PaginatedList.empty(),
        savedPosts = const PaginatedList.empty(),
        seedsCountResult = const FutureResult.empty(),
        seedCount = 0,
        collectionsResult = const FutureResult.empty(),
        collections = const PaginatedList.empty(),
        userCirclesResult = const FutureResult.empty(),
        postsResult = const FutureResult.empty(),
        savedPostsResult = const FutureResult.empty(),
        profileStatsResult = const FutureResult.empty(),
        profileStats = const ProfileStats.empty(),
        userResult = const FutureResult.empty(),
        userCircles = const PaginatedList.empty(),
        user = userStore.privateProfile,
        featureFlags = featureFlagsStore.featureFlags,
        unreadNotificationsCount = const UnreadNotificationsCount.empty(),
        contactsPermission = RuntimePermissionStatus.unknown,
        circle = const Circle.empty();

  /// Used for the copyWith method
  PrivateProfilePresentationModel._({
    required this.selectedTab,
    required this.posts,
    required this.savedPosts,
    required this.collectionsResult,
    required this.userCirclesResult,
    required this.collections,
    required this.userCircles,
    required this.user,
    required this.userResult,
    required this.postsResult,
    required this.savedPostsResult,
    required this.profileStatsResult,
    required this.profileStats,
    required this.featureFlags,
    required this.unreadNotificationsCount,
    required this.contactsPermission,
    required this.circle,
    required this.seedCount,
    required this.seedsCountResult,
  });

  final FutureResult<Either<GetUserCirclesFailure, PaginatedList<Circle>>> userCirclesResult;
  final FutureResult<Either<GetCollectionsFailure, PaginatedList<Collection>>> collectionsResult;
  final FutureResult<Either<GetPrivateProfileFailure, PrivateProfile>> userResult;
  final FutureResult<Either<GetProfileStatsFailure, ProfileStats>> profileStatsResult;
  final FutureResult<Either<GetUserSeedsTotalFailure, int>> seedsCountResult;

  final FutureResult<Either<GetPostsFailure, PaginatedList<Post>>> postsResult;

  final FutureResult<Either<GetSavedPostsFailure, PaginatedList<Post>>> savedPostsResult;

  @override
  final PrivateProfileTab selectedTab;

  @override
  final PaginatedList<Post> posts;

  @override
  final PaginatedList<Post> savedPosts;

  @override
  final ProfileStats profileStats;

  @override
  final PaginatedList<Circle> userCircles;

  @override
  final PaginatedList<Collection> collections;

  final FeatureFlags featureFlags;

  @override
  final PrivateProfile user;

  @override
  final UnreadNotificationsCount unreadNotificationsCount;

  @override
  final RuntimePermissionStatus contactsPermission;

  @override
  final Circle circle;

  @override
  final int seedCount;

  @override
  bool get isLoadingCollections => collectionsResult.isPending();

  @override
  String get seeds => isLoadingSeedsCount ? ' ' : '$seedCount';

  @override
  bool get isLoadingProfileStats => profileStatsResult.isPending();

  @override
  bool get isLoadingUser => userResult.isPending();

  @override
  bool get enableAddFriends => featureFlags[FeatureFlagType.phoneContactsSharingEnable];

  @override
  bool get isPostsLoading => postsResult.isPending();

  @override
  bool get isCirclesLoading => userCirclesResult.isPending();

  Cursor get collectionCursor => collections.nextPageCursor();

  Cursor get userCirclesCursor => userCircles.nextPageCursor();

  @override
  bool get shouldSeedsBeVisible => featureFlags[FeatureFlagType.seedsProfileCircleEnabled];

  @override
  bool get savedPostsLoading => savedPostsResult.isPending();

  @override
  bool get isLoadingSeedsCount => seedsCountResult.isPending();

  @override
  List<PrivateProfileTab> get tabs {
    return [
      PrivateProfileTab.posts,
      PrivateProfileTab.circles,
      if (featureFlags[FeatureFlagType.collectionsEnabled]) PrivateProfileTab.collections,
    ];
  }

  @override
  bool get isMuteCircleEnabled => featureFlags[FeatureFlagType.isMuteCircleEnabled];

  @override
  bool get isDirector => circle.isDirector;

  PrivateProfilePresentationModel byUpdatingProfileStats({
    required ProfileStats profileStats,
  }) =>
      copyWith(profileStats: profileStats);

  PrivateProfilePresentationModel byAppendingSavedPostsList(PaginatedList<Post> newList) => copyWith(
        savedPosts: savedPosts + newList,
      );

  PrivateProfilePresentationModel bySelectingCircle(Circle circle) => copyWith(
        circle: circle,
      );

  PrivateProfilePresentationModel byRemoveUserCircleFromList(Circle circle) => copyWith(
        userCircles: userCircles.byRemoving(element: circle),
      );

  PrivateProfilePresentationModel copyWith({
    FutureResult<Either<GetUserCirclesFailure, PaginatedList<Circle>>>? userCirclesResult,
    FutureResult<Either<GetCollectionsFailure, PaginatedList<Collection>>>? collectionsResult,
    FutureResult<Either<GetPrivateProfileFailure, PrivateProfile>>? userResult,
    FutureResult<Either<GetProfileStatsFailure, ProfileStats>>? profileStatsResult,
    FutureResult<Either<GetUserSeedsTotalFailure, int>>? seedsCountResult,
    ProfileStats? profileStats,
    FutureResult<Either<GetPostsFailure, PaginatedList<Post>>>? postsResult,
    PrivateProfileTab? selectedTab,
    PaginatedList<Post>? posts,
    PaginatedList<Post>? savedPosts,
    PaginatedList<Circle>? userCircles,
    PaginatedList<Collection>? collections,
    FeatureFlags? featureFlags,
    PrivateProfile? user,
    UnreadNotificationsCount? unreadNotificationsCount,
    RuntimePermissionStatus? contactsPermission,
    FutureResult<Either<GetSavedPostsFailure, PaginatedList<Post>>>? savedPostsResult,
    Circle? circle,
    int? seedCount,
  }) {
    return PrivateProfilePresentationModel._(
      profileStatsResult: profileStatsResult ?? this.profileStatsResult,
      profileStats: profileStats ?? this.profileStats,
      userCirclesResult: userCirclesResult ?? this.userCirclesResult,
      collectionsResult: collectionsResult ?? this.collectionsResult,
      userResult: userResult ?? this.userResult,
      postsResult: postsResult ?? this.postsResult,
      savedPostsResult: savedPostsResult ?? this.savedPostsResult,
      selectedTab: selectedTab ?? this.selectedTab,
      posts: posts ?? this.posts,
      savedPosts: savedPosts ?? this.savedPosts,
      userCircles: userCircles ?? this.userCircles,
      collections: collections ?? this.collections,
      featureFlags: featureFlags ?? this.featureFlags,
      user: user ?? this.user,
      unreadNotificationsCount: unreadNotificationsCount ?? this.unreadNotificationsCount,
      contactsPermission: contactsPermission ?? this.contactsPermission,
      circle: circle ?? this.circle,
      seedCount: seedCount ?? this.seedCount,
      seedsCountResult: seedsCountResult ?? this.seedsCountResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PrivateProfileViewModel {
  PrivateProfileTab get selectedTab;

  PaginatedList<Post> get posts;

  PaginatedList<Post> get savedPosts;

  PaginatedList<Circle> get userCircles;

  PaginatedList<Collection> get collections;

  bool get isLoadingCollections;

  bool get isLoadingUser;

  bool get isPostsLoading;

  bool get isCirclesLoading;

  PrivateProfile get user;

  int get seedCount;

  List<PrivateProfileTab> get tabs;

  bool get shouldSeedsBeVisible;

  UnreadNotificationsCount get unreadNotificationsCount;

  ProfileStats get profileStats;

  bool get isLoadingProfileStats;

  bool get isLoadingSeedsCount;

  bool get enableAddFriends;

  RuntimePermissionStatus get contactsPermission;

  bool get savedPostsLoading;

  Circle get circle;

  bool get isMuteCircleEnabled;

  bool get isDirector;

  String get seeds;
}
