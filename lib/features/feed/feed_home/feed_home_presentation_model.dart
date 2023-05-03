import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_circles_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/get_feeds_list_failure.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presentation_model.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class FeedHomePresentationModel implements FeedHomeViewModel {
  /// Creates the initial state
  FeedHomePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    FeedHomeInitialParams initialParams,
    FeatureFlagsStore featureFlags,
    UserCirclesStore userCirclesStore,
    UserStore userStore,
  )   : remoteFeedsResult = const StreamResult.empty(),
        currentPost = const Post.empty(),
        onPostChangedCallback = initialParams.onPostChanged,
        featureFlags = featureFlags.featureFlags,
        remoteFeeds = const PaginatedList.empty(),
        selectedFeed = const Feed.empty(),
        localFeeds = [],
        forYouLocalPost = initialParams.postToShow,
        userCircles = userCirclesStore.userCircles,
        privateProfile = userStore.privateProfile,
        onCirclesSideMenuToggled = initialParams.onCirclesSideMenuToggled;

  /// Used for the copyWith method
  FeedHomePresentationModel._({
    required this.remoteFeedsResult,
    required this.selectedFeed,
    required this.currentPost,
    required this.forYouLocalPost,
    required this.onPostChangedCallback,
    required this.remoteFeeds,
    required this.featureFlags,
    required this.localFeeds,
    required this.userCircles,
    required this.privateProfile,
    required this.onCirclesSideMenuToggled,
  });

  final StreamResult<CacheableResult<GetFeedsListFailure, List<Feed>>> remoteFeedsResult;
  final OnDisplayedPostChangedCallback onPostChangedCallback;

  final Post currentPost;

  final VoidCallback onCirclesSideMenuToggled;

  @override
  final PaginatedList<BasicCircle> userCircles;

  @override
  final Post forYouLocalPost;

  @override
  final FeatureFlags featureFlags;

  @override
  final Feed selectedFeed;

  final PaginatedList<Feed> remoteFeeds;

  final List<Feed> localFeeds;

  final PrivateProfile privateProfile;

  @override
  List<Feed> get feeds => [...remoteFeeds, ...localFeeds];

  @override
  int get selectedFeedIndex => feeds.indexOf(selectedFeed);

  @override
  bool get isLoading => remoteFeedsResult.isPending && !remoteFeedsResult.isEmission;

  @override
  bool get showSeeMoreButton => seeMoreButtonEnable && remoteFeeds.hasNextPage;

  @override
  PostOverlayTheme get overlayTheme => currentPost.overlayTheme;

  bool get seeMoreButtonEnable => featureFlags[FeatureFlagType.circlesSeeMoreEnabled];

  @override
  ImageUrl get profileImageUrl => privateProfile.profileImageUrl;

  FeedHomePresentationModel copyWith({
    StreamResult<CacheableResult<GetFeedsListFailure, List<Feed>>>? remoteFeedsResult,
    OnDisplayedPostChangedCallback? onPostChangedCallback,
    Post? currentPost,
    Post? forYouLocalPost,
    FeatureFlags? featureFlags,
    Feed? selectedFeed,
    PaginatedList<Feed>? remoteFeeds,
    List<Feed>? localFeeds,
    PaginatedList<BasicCircle>? userCircles,
    PrivateProfile? privateProfile,
    VoidCallback? onCirclesSideMenuToggled,
  }) {
    return FeedHomePresentationModel._(
      remoteFeedsResult: remoteFeedsResult ?? this.remoteFeedsResult,
      onPostChangedCallback: onPostChangedCallback ?? this.onPostChangedCallback,
      currentPost: currentPost ?? this.currentPost,
      forYouLocalPost: forYouLocalPost ?? this.forYouLocalPost,
      featureFlags: featureFlags ?? this.featureFlags,
      selectedFeed: selectedFeed ?? this.selectedFeed,
      remoteFeeds: remoteFeeds ?? this.remoteFeeds,
      localFeeds: localFeeds ?? this.localFeeds,
      userCircles: userCircles ?? this.userCircles,
      privateProfile: privateProfile ?? this.privateProfile,
      onCirclesSideMenuToggled: onCirclesSideMenuToggled ?? this.onCirclesSideMenuToggled,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class FeedHomeViewModel {
  Post get forYouLocalPost;

  int get selectedFeedIndex;

  bool get isLoading;

  List<Feed> get feeds;

  Feed get selectedFeed;

  PostOverlayTheme get overlayTheme;

  FeatureFlags get featureFlags;

  bool get showSeeMoreButton;

  PaginatedList<BasicCircle> get userCircles;

  ImageUrl get profileImageUrl;
}
