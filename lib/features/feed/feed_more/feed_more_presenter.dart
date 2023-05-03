import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/stores/local_feeds_store.dart';
import 'package:picnic_app/features/feed/domain/use_cases/get_feeds_list_use_case.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_navigator.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_presentation_model.dart';

class FeedMorePresenter extends Cubit<FeedMoreViewModel> {
  FeedMorePresenter(
    super.model,
    this.navigator,
    this._getFeedsListUseCase,
    this._localFeedsStore,
  );

  final FeedMoreNavigator navigator;
  final GetFeedsListUseCase _getFeedsListUseCase;
  final LocalFeedsStore _localFeedsStore;

  static const _feedPageSizeDefault = 20;

  int get _feedPageSize => _feedPageSizeDefault + _localFeedsStore.feeds.length;

  // ignore: unused_element
  FeedMorePresentationModel get _model => state as FeedMorePresentationModel;

  void onTapFeed(Feed feed) => navigator.closeWithResult(feed);

  Future<void> loadMore() {
    return _getFeedsListUseCase
        .execute(nextPageCursor: _model.feedsList.nextPageCursor(pageSize: _feedPageSize))
        .networkResult
        .observeStatusChanges((result) => tryEmit(_model.copyWith(feedsListResult: result)))
        .doOn(
      success: (list) {
        final localFeedsIds = _localFeedsStore.feeds.map((feed) => feed.id).toSet();
        final feedsWithoutLocals = list.copyWith(
          items: list.items.where((feed) => !localFeedsIds.contains(feed.id)).toList(),
        );
        tryEmit(_model.byAppendingFeeds(feedsWithoutLocals));
      },
    );
  }
}
