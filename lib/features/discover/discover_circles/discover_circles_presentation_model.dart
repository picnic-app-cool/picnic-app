import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_initial_params.dart';
import 'package:picnic_app/features/discover/domain/model/circle_group.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class DiscoverCirclesPresentationModel implements DiscoverCirclesViewModel {
  /// Creates the initial state
  DiscoverCirclesPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    DiscoverCirclesInitialParams initialParams,
  )   : feedGroups = <CircleGroup>[],
        viewCircleCallBack = initialParams.onCircleViewed,
        popularFeedPosts = <Post>[];

  /// Used for the copyWith method
  DiscoverCirclesPresentationModel._({
    required this.feedGroups,
    required this.popularFeedPosts,
    required this.viewCircleCallBack,
  });

  final VoidCallback? viewCircleCallBack;

  @override
  final List<CircleGroup> feedGroups;

  @override
  final List<Post> popularFeedPosts;

  @override
  List<Circle> get trendingCircles => feedGroups.map((e) => e.topCircles).expand((e) => e).toList();

  @override
  bool get isLoading => trendingCircles.isEmpty || feedGroups.isEmpty;

  DiscoverCirclesPresentationModel copyWith({
    List<CircleGroup>? feedGroups,
    List<Post>? popularFeedPosts,
    VoidCallback? viewCircleCallBack,
  }) {
    return DiscoverCirclesPresentationModel._(
      feedGroups: feedGroups ?? this.feedGroups,
      popularFeedPosts: popularFeedPosts ?? this.popularFeedPosts,
      viewCircleCallBack: viewCircleCallBack ?? this.viewCircleCallBack,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class DiscoverCirclesViewModel {
  List<CircleGroup> get feedGroups;

  List<Post> get popularFeedPosts;

  List<Circle> get trendingCircles;

  bool get isLoading;
}
