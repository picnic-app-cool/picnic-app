import 'package:dartz/dartz.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_stats.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/follow_unfollow_user_failure.dart';
import 'package:picnic_app/core/domain/model/get_circle_stats_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member.dart';
import 'package:picnic_app/features/circles/domain/model/circle_tab.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_details_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_last_used_sorting_option_failure.dart';
import 'package:picnic_app/features/circles/domain/model/royalty.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/seeds/domain/model/election.dart';
import 'package:picnic_app/features/seeds/domain/model/seed_holder.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleDetailsPresentationModel implements CircleDetailsViewModel {
  /// Creates the initial state
  CircleDetailsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleDetailsInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
    UserStore userStore,
    this.currentTimeProvider,
  )   : selectedTab = CircleTab.posts,
        circleDetailsResult = const FutureResult.empty(),
        circleStatsResult = const FutureResult.empty(),
        lastUsedSortingOptionResult = const FutureResult.empty(),
        circle = const Circle.empty(),
        posts = const PaginatedList.empty(),
        slices = const PaginatedList.empty(),
        id = initialParams.circleId,
        onCircleMembershipChangeCallback = initialParams.onCircleMembershipChange,
        royals = const PaginatedList.empty(),
        circleStats = const CircleStats.empty(),
        directors = const PaginatedList.empty(),
        seedHolders = const PaginatedList.empty(),
        featureFlags = featureFlagsStore.featureFlags,
        postSortOption = PostsSortingType.trendingThisWeek,
        isMultiSelectionEnabled = false,
        election = const Election.empty(),
        selectedPosts = [],
        showSortInAppBar = false,
        showAppBarBackgroundColor = false,
        pageVisible = false,
        showSettingsIconButton = true,
        savePostResult = const FutureResult.empty(),
        maxCommentsCount = Constants.defaultCommentsPreviewCount,
        members = const PaginatedList.empty(),
        privateProfile = userStore.privateProfile,
        toggleFollowResult = const FutureResult.empty();

  /// Used for the copyWith method
  CircleDetailsPresentationModel._({
    required this.featureFlags,
    required this.selectedTab,
    required this.seedHolders,
    required this.circleDetailsResult,
    required this.circleStatsResult,
    required this.lastUsedSortingOptionResult,
    required this.circle,
    required this.election,
    required this.posts,
    required this.royals,
    required this.id,
    required this.directors,
    required this.onCircleMembershipChangeCallback,
    required this.currentTimeProvider,
    required this.circleStats,
    required this.slices,
    required this.postSortOption,
    required this.isMultiSelectionEnabled,
    required this.selectedPosts,
    required this.showSortInAppBar,
    required this.showSettingsIconButton,
    required this.savePostResult,
    required this.maxCommentsCount,
    required this.pageVisible,
    required this.showAppBarBackgroundColor,
    required this.members,
    required this.privateProfile,
    required this.toggleFollowResult,
  });

  final VoidCallback? onCircleMembershipChangeCallback;

  final FutureResult<Either<GetCircleDetailsFailure, Circle>> circleDetailsResult;
  final FutureResult<Either<GetCircleStatsFailure, CircleStats>> circleStatsResult;
  final FutureResult<Either<GetLastUsedSortingOptionFailure, PostsSortingType>> lastUsedSortingOptionResult;
  final FutureResult<Either<SavePostToCollectionFailure, Post>> savePostResult;
  final FutureResult<Either<FollowUnfollowUserFailure, Unit>> toggleFollowResult;

  final int maxCommentsCount;

  @override
  final CircleTab selectedTab;

  @override
  final bool showAppBarBackgroundColor;

  @override
  final bool pageVisible;

  @override
  final Election election;

  @override
  final Circle circle;

  @override
  final CurrentTimeProvider currentTimeProvider;

  @override
  final PaginatedList<Post> posts;

  @override
  final PaginatedList<Slice> slices;

  @override
  final PaginatedList<Royalty> royals;

  @override
  final PaginatedList<CircleMember> directors;

  @override
  final CircleStats circleStats;

  final Id id;
  final FeatureFlags featureFlags;

  @override
  final PostsSortingType postSortOption;

  @override
  final bool isMultiSelectionEnabled;

  @override
  final List<Post> selectedPosts;

  final PaginatedList<SeedHolder> seedHolders;

  @override
  final bool showSortInAppBar;

  @override
  final bool showSettingsIconButton;

  @override
  final PaginatedList<CircleMember> members;

  @override
  final PrivateProfile privateProfile;

  @override
  DateTime? get deadline => election.dueToFormat;

  @override
  bool get isLoadingCircle => circleDetailsResult.isPending();

  @override
  bool get isLoadingStats => circleStatsResult.isPending();

  @override
  bool get isLoadingLastUsedSortingOption => lastUsedSortingOptionResult.isPending();

  @override
  bool get areSeedsEnabled => featureFlags[FeatureFlagType.seedsProfileCircleEnabled];

  @override
  //ignore: no-magic-number
  int get slicesMemberCount => 14;

  @override
  bool get isMuteCircleEnabled => featureFlags[FeatureFlagType.isMuteCircleEnabled];

  @override
  bool get isPostingEnabled => circle.postingEnabled;

  @override
  bool get hasPermissionToPost => circle.hasPermissionToPost;

  Cursor get directorsCursor => directors.nextPageCursor();

  Cursor get membersCursor => members.nextPageCursor();

  @override
  List<CircleTab> get tabs {
    return [
      CircleTab.posts,
      CircleTab.preview,
      if (featureFlags[FeatureFlagType.royaltyTabEnabled]) CircleTab.royalty,
      CircleTab.members,
      CircleTab.rules,
      if (slicesEnabled) CircleTab.slices,
    ];
  }

  @override
  bool get hasModerationPermissions => circle.hasAnyModerationPermission;

  @override
  bool get isDirector => circle.isDirector;

  @override
  bool get slicesEnabled => featureFlags[FeatureFlagType.slicesEnabled];

  @override
  bool get showCountDownWidget => featureFlags[FeatureFlagType.enableEectionCountDownWidget];

  //TODO: remove once BE integrated : https://picnic-app.atlassian.net/browse/GS-6903
  @override
  int get seedsCount =>
      seedHolders.items.fold(0, (previousValue, seedHolder) => previousValue + seedHolder.amountTotal);

  @override
  //ignore: no-magic-number
  int get slicesCount => 181; //TODO: remove once BE integrated : https://picnic-app.atlassian.net/browse/GS-5025

  @override
  String get rules => circle.rulesText;

  @override
  bool get showPostSortBottomSheet =>
      featureFlags[FeatureFlagType.showCirclePostSorting] &&
      (selectedTab == CircleTab.posts || selectedTab == CircleTab.preview) &&
      !isLoadingLastUsedSortingOption;

  @override
  bool get showPrivateCircleWarning => !circle.iJoined && circle.visibility == CircleVisibility.private;

  @override
  bool get savedPostsEnabled => featureFlags[FeatureFlagType.savedPostsEnabled];

  @override
  bool get showSavePostToCollection => featureFlags[FeatureFlagType.collectionsEnabled];

  @override
  bool get coverExists => circle.coverImage.isNotEmpty;

  @override
  bool get setIconTintColor => coverExists && !showAppBarBackgroundColor && pageVisible;

  @override
  bool get isLoadingToggleFollow => toggleFollowResult.isPending();

  @override
  bool get hasPermissionToManageCircle => circle.hasPermissionToManageCircle;

  @override
  bool get hasPermissionReports => circle.hasPermissionToManageReports;

  CircleDetailsPresentationModel byUpdatingCircle(Circle circle) =>
      copyWith(circle: circle.copyWith(iJoined: circle.iJoined));

  CircleDetailsPresentationModel byAppendingPostsList(
    PaginatedList<Post> newList,
  ) =>
      copyWith(
        posts: posts + newList,
      );

  CircleDetailsPresentationModel byAppendingDirectorsList(
    PaginatedList<CircleMember> newList,
  ) =>
      copyWith(
        directors: directors + newList,
      );

  CircleDetailsPresentationModel byAppendingMembersList(PaginatedList<CircleMember> newList) => copyWith(
        members: members + newList,
      );

  CircleDetailsPresentationModel byAppendingRoyaltyList(
    PaginatedList<Royalty> newList,
  ) =>
      copyWith(
        royals: royals + newList,
      );

  CircleDetailsPresentationModel byUpdateFollowAction(CircleMember member) => copyWith(
        members: members.byUpdatingItem(
          update: (update) => update.copyWith(user: update.user.copyWith(iFollow: !update.user.iFollow)),
          itemFinder: (finder) => member.user.id == finder.user.id,
        ),
      );

  // ignore: long-method
  CircleDetailsPresentationModel byUpdatingPost(Post updatedPost) {
    final newPostsList = <Post>[];
    for (final post in posts) {
      if (post.id == updatedPost.id) {
        newPostsList.add(updatedPost);
        continue;
      }

      var tempPost = post;

      final isSamePostAuthor = post.author.id == updatedPost.author.id;
      final isSamePostId = post.id == updatedPost.id;

      final newFollowAuthorStatus = updatedPost.author.iFollow;
      if (isSamePostAuthor && post.author.iFollow != newFollowAuthorStatus) {
        tempPost = tempPost.copyWith(
          author: tempPost.author.copyWith(iFollow: newFollowAuthorStatus),
        );
      }

      final newJoinedCircleStatus = updatedPost.circle.iJoined;
      if (post.circle.id == updatedPost.circle.id && post.circle.iJoined != newJoinedCircleStatus) {
        tempPost = tempPost.copyWith(
          circle: tempPost.circle.copyWith(iJoined: newJoinedCircleStatus),
        );
      }

      if (isSamePostId) {
        tempPost = tempPost.copyWith(context: updatedPost.context);
        tempPost = tempPost.copyWith(contentStats: updatedPost.contentStats);
      }

      newPostsList.add(tempPost);
    }

    return copyWith(posts: posts.copyWith(items: newPostsList));
  }

  CircleDetailsPresentationModel copyWith({
    FutureResult<Either<GetCircleDetailsFailure, Circle>>? circleDetailsResult,
    FutureResult<Either<GetCircleStatsFailure, CircleStats>>? circleStatsResult,
    FutureResult<Either<GetLastUsedSortingOptionFailure, PostsSortingType>>? lastUsedSortingOptionResult,
    CircleTab? selectedTab,
    VoidCallback? onCircleMembershipChangeCallback,
    Circle? circle,
    PaginatedList<Post>? posts,
    PaginatedList<Slice>? slices,
    PaginatedList<Royalty>? royals,
    PaginatedList<CircleMember>? directors,
    CurrentTimeProvider? currentTimeProvider,
    CircleStats? circleStats,
    Id? id,
    FeatureFlags? featureFlags,
    PostsSortingType? postSortOption,
    bool? isMultiSelectionEnabled,
    List<Post>? selectedPosts,
    PaginatedList<SeedHolder>? seedHolders,
    bool? showSortInAppBar,
    bool? showSettingsIconButton,
    bool? pageVisible,
    Election? election,
    FutureResult<Either<SavePostToCollectionFailure, Post>>? savePostResult,
    int? maxCommentsCount,
    bool? showAppBarBackgroundColor,
    PaginatedList<CircleMember>? members,
    PrivateProfile? privateProfile,
    FutureResult<Either<FollowUnfollowUserFailure, Unit>>? toggleFollowResult,
  }) {
    return CircleDetailsPresentationModel._(
      circleDetailsResult: circleDetailsResult ?? this.circleDetailsResult,
      seedHolders: seedHolders ?? this.seedHolders,
      circleStatsResult: circleStatsResult ?? this.circleStatsResult,
      lastUsedSortingOptionResult: lastUsedSortingOptionResult ?? this.lastUsedSortingOptionResult,
      selectedTab: selectedTab ?? this.selectedTab,
      onCircleMembershipChangeCallback: onCircleMembershipChangeCallback ?? this.onCircleMembershipChangeCallback,
      circle: circle ?? this.circle,
      posts: posts ?? this.posts,
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      slices: slices ?? this.slices,
      royals: royals ?? this.royals,
      directors: directors ?? this.directors,
      circleStats: circleStats ?? this.circleStats,
      id: id ?? this.id,
      featureFlags: featureFlags ?? this.featureFlags,
      postSortOption: postSortOption ?? this.postSortOption,
      isMultiSelectionEnabled: isMultiSelectionEnabled ?? this.isMultiSelectionEnabled,
      selectedPosts: selectedPosts ?? this.selectedPosts,
      showSortInAppBar: showSortInAppBar ?? this.showSortInAppBar,
      showSettingsIconButton: showSettingsIconButton ?? this.showSettingsIconButton,
      election: election ?? this.election,
      savePostResult: savePostResult ?? this.savePostResult,
      maxCommentsCount: maxCommentsCount ?? this.maxCommentsCount,
      pageVisible: pageVisible ?? this.pageVisible,
      showAppBarBackgroundColor: showAppBarBackgroundColor ?? this.showAppBarBackgroundColor,
      members: members ?? this.members,
      privateProfile: privateProfile ?? this.privateProfile,
      toggleFollowResult: toggleFollowResult ?? this.toggleFollowResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleDetailsViewModel {
  CircleTab get selectedTab;

  Circle get circle;

  int get seedsCount;

  PaginatedList<Post> get posts;

  PaginatedList<Slice> get slices;

  PaginatedList<Royalty> get royals;

  PaginatedList<CircleMember> get directors;

  String get rules;

  bool get isLoadingCircle;

  bool get hasModerationPermissions;

  bool get isDirector;

  List<CircleTab> get tabs;

  bool get areSeedsEnabled;

  int get slicesCount;

  bool get slicesEnabled;

  int get slicesMemberCount;

  CircleStats get circleStats;

  bool get isLoadingStats;

  bool get isMuteCircleEnabled;

  PostsSortingType get postSortOption;

  bool get showPostSortBottomSheet;

  bool get showPrivateCircleWarning;

  bool get isMultiSelectionEnabled;

  List<Post> get selectedPosts;

  bool get showSortInAppBar;

  bool get showAppBarBackgroundColor;

  bool get showCountDownWidget;

  bool get showSettingsIconButton;

  CurrentTimeProvider get currentTimeProvider;

  DateTime? get deadline;

  Election get election;

  bool get isLoadingLastUsedSortingOption;

  bool get isPostingEnabled;

  bool get hasPermissionToPost;

  bool get savedPostsEnabled;

  bool get showSavePostToCollection;

  bool get coverExists;

  bool get pageVisible;

  bool get setIconTintColor;

  PaginatedList<CircleMember> get members;

  PrivateProfile get privateProfile;

  bool get isLoadingToggleFollow;

  bool get hasPermissionToManageCircle;

  bool get hasPermissionReports;
}
