import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/get_collections_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_circles_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/model/get_profile_stats_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_user_posts_failure.dart';
import 'package:picnic_app/features/profile/domain/model/public_profile_action.dart';
import 'package:picnic_app/features/profile/domain/public_profile_tab.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PublicProfilePresentationModel implements PublicProfileViewModel {
  /// Creates the initial state
  PublicProfilePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PublicProfileInitialParams initialParams,
    UserStore userStore,
    FeatureFlagsStore featureFlagsStore,
  )   : selectedTab = PublicProfileTab.posts,
        posts = const PaginatedList.empty(),
        userResult = const FutureResult.empty(),
        collectionsResult = const FutureResult.empty(),
        collections = const PaginatedList.empty(),
        userCirclesResult = const FutureResult.empty(),
        postsResult = const FutureResult.empty(),
        userCircles = const PaginatedList.empty(),
        publicProfile = const PublicProfile.empty(),
        profileStatsResult = const FutureResult.empty(),
        profileStats = const ProfileStats.empty(),
        action = PublicProfileAction.follow,
        userId = initialParams.userId,
        featureFlags = featureFlagsStore.featureFlags,
        privateProfile = userStore.privateProfile,
        followResult = const FutureResult.empty();

  /// Used for the copyWith method
  PublicProfilePresentationModel._({
    required this.featureFlags,
    required this.selectedTab,
    required this.action,
    required this.posts,
    required this.userResult,
    required this.userCirclesResult,
    required this.collectionsResult,
    required this.collections,
    required this.userCircles,
    required this.userId,
    required this.publicProfile,
    required this.postsResult,
    required this.privateProfile,
    required this.followResult,
    required this.profileStatsResult,
    required this.profileStats,
  });

  final FutureResult<Either<GetUserFailure, PublicProfile>> userResult;

  final FutureResult<Either<GetUserCirclesFailure, PaginatedList<Circle>>> userCirclesResult;
  final FutureResult<Either<GetProfileStatsFailure, ProfileStats>> profileStatsResult;

  final FutureResult<Either<GetCollectionsFailure, PaginatedList<Collection>>> collectionsResult;
  final FutureResult<Either<GetUserPostsFailure, PaginatedList<Post>>> postsResult;

  final PrivateProfile privateProfile;

  @override
  final PublicProfile publicProfile;

  @override
  final PublicProfileTab selectedTab;

  final Id userId;

  @override
  final ProfileStats profileStats;

  @override
  final PublicProfileAction action;

  @override
  final PaginatedList<Post> posts;

  @override
  final PaginatedList<Circle> userCircles;

  @override
  final PaginatedList<Collection> collections;

  final FeatureFlags featureFlags;

  @override
  final FutureResult<void> followResult;

  @override
  String get shareProfileUrl => publicProfile.user.shareLink;

  @override
  bool get isLoadingCollections => collectionsResult.isPending();

  @override
  bool get isPostsLoading => postsResult.isPending();

  @override
  bool get isLoadingUser => userResult.isPending();

  @override
  bool get isCirclesLoading => userCirclesResult.isPending();

  @override
  bool get isLoadingProfileStats => profileStatsResult.isPending();

  @override
  bool get isBlocked => publicProfile.isBlocked;

  List<Id> get singleChatUserIds => List.unmodifiable([privateProfile.id, userId]);

  Cursor get collectionCursor => collections.nextPageCursor();

  Cursor get userCirclesCursor => userCircles.nextPageCursor();

  @override
  List<PublicProfileTab> get tabs {
    return [
      PublicProfileTab.posts,
      PublicProfileTab.circles,
      if (featureFlags[FeatureFlagType.collectionsEnabled]) PublicProfileTab.collections,
    ];
  }

  PublicProfilePresentationModel byUpdatingPublicProfile({
    required PublicProfile publicProfile,
  }) =>
      copyWith(publicProfile: publicProfile);

  PublicProfilePresentationModel byUpdatingProfileStats({
    required ProfileStats profileStats,
  }) =>
      copyWith(profileStats: profileStats);

  PublicProfilePresentationModel copyWith({
    FutureResult<Either<GetUserFailure, PublicProfile>>? userResult,
    FutureResult<Either<GetUserCirclesFailure, PaginatedList<Circle>>>? userCirclesResult,
    FutureResult<Either<GetCollectionsFailure, PaginatedList<Collection>>>? collectionsResult,
    FutureResult<Either<GetUserPostsFailure, PaginatedList<Post>>>? postsResult,
    FutureResult<Either<GetProfileStatsFailure, ProfileStats>>? profileStatsResult,
    ProfileStats? profileStats,
    PrivateProfile? privateProfile,
    PublicProfileTab? selectedTab,
    Id? userId,
    PublicProfileAction? action,
    PaginatedList<Post>? posts,
    PaginatedList<Circle>? userCircles,
    PaginatedList<Collection>? collections,
    PublicProfile? publicProfile,
    FeatureFlags? featureFlags,
    FutureResult<void>? followResult,
  }) {
    return PublicProfilePresentationModel._(
      userResult: userResult ?? this.userResult,
      userCirclesResult: userCirclesResult ?? this.userCirclesResult,
      profileStatsResult: profileStatsResult ?? this.profileStatsResult,
      profileStats: profileStats ?? this.profileStats,
      collectionsResult: collectionsResult ?? this.collectionsResult,
      postsResult: postsResult ?? this.postsResult,
      privateProfile: privateProfile ?? this.privateProfile,
      selectedTab: selectedTab ?? this.selectedTab,
      userId: userId ?? this.userId,
      publicProfile: publicProfile ?? this.publicProfile,
      followResult: followResult ?? this.followResult,
      action: action ?? this.action,
      posts: posts ?? this.posts,
      userCircles: userCircles ?? this.userCircles,
      collections: collections ?? this.collections,
      featureFlags: featureFlags ?? this.featureFlags,
    );
  }

  PublicProfileViewModel byUpdatingPostInList(Post updatedPost) => copyWith(
        posts: posts.byUpdatingItem(
          itemFinder: (item) => item.id == updatedPost.id,
          update: (update) => updatedPost,
        ),
      );
}

/// Interface to expose fields used by the view (page).
abstract class PublicProfileViewModel {
  PublicProfile get publicProfile;

  PublicProfileAction get action;

  PublicProfileTab get selectedTab;

  PaginatedList<Post> get posts;

  PaginatedList<Circle> get userCircles;

  PaginatedList<Collection> get collections;

  bool get isLoadingCollections;

  bool get isPostsLoading;

  bool get isLoadingUser;

  bool get isLoadingProfileStats;

  bool get isCirclesLoading;

  String get shareProfileUrl;

  bool get isBlocked;

  List<PublicProfileTab> get tabs;

  FutureResult<void> get followResult;

  ProfileStats get profileStats;
}
