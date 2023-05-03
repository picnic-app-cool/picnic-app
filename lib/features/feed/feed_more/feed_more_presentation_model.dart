import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/get_feeds_list_failure.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class FeedMorePresentationModel implements FeedMoreViewModel {
  /// Creates the initial state
  FeedMorePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    FeedMoreInitialParams initialParams,
  )   : feedsListResult = const FutureResult.empty(),
        feedsList = PaginatedList(
          items: [],
          pageInfo: PageInfo(
            hasNextPage: true,
            hasPreviousPage: false,
            nextPageId: initialParams.initialFeedsPageId,
            previousPageId: const Id.none(),
          ),
        );

  /// Used for the copyWith method
  FeedMorePresentationModel._({
    required this.feedsList,
    required this.feedsListResult,
  });

  final FutureResult<Either<GetFeedsListFailure, List<Feed>>> feedsListResult;

  @override
  final PaginatedList<Feed> feedsList;

  FeedMorePresentationModel byAppendingFeeds(
    PaginatedList<Feed> feeds,
  ) {
    return copyWith(
      feedsList: feedsList + feeds,
    );
  }

  FeedMorePresentationModel copyWith({
    FutureResult<Either<GetFeedsListFailure, List<Feed>>>? feedsListResult,
    PaginatedList<Feed>? feedsList,
  }) {
    return FeedMorePresentationModel._(
      feedsListResult: feedsListResult ?? this.feedsListResult,
      feedsList: feedsList ?? this.feedsList,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class FeedMoreViewModel {
  PaginatedList<Feed> get feedsList;
}
