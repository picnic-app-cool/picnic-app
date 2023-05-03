import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/feed_more/widgets/feed_list_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/empty_message_widget.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class FeedMoreListView extends StatelessWidget {
  const FeedMoreListView({
    Key? key,
    required this.feedsList,
    required this.loadMore,
    required this.onTapFeed,
    required this.isEmpty,
  }) : super(key: key);

  final PaginatedList<Feed> feedsList;
  final Future<void> Function() loadMore;
  final ValueChanged<Feed> onTapFeed;

  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    const _topPadding = 4.0;
    return AnimatedSwitcher(
      duration: const ShortDuration(),
      child: isEmpty
          ? EmptyMessageWidget(
              message: appLocalizations.emptyUserCirclesMessage,
            )
          : PicnicPagingListView<Feed>(
              padding: EdgeInsets.only(
                top: _topPadding,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              loadMore: loadMore,
              paginatedList: feedsList,
              loadingBuilder: (_) => const PicnicLoadingIndicator(),
              itemBuilder: (context, feed) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: FeedListItem(
                  feed: feed,
                  onTap: () => onTapFeed.call(feed),
                ),
              ),
            ),
    );
  }
}
