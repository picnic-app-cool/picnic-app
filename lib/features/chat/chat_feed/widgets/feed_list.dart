import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/chat_feed/widgets/feed_list_item.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_feed.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class FeedList extends StatelessWidget {
  const FeedList({
    Key? key,
    required this.chatMessagesFeedList,
    required this.loadMore,
    required this.onTapCircle,
    this.onTapFeed,
  }) : super(key: key);

  final PaginatedList<ChatMessagesFeed> chatMessagesFeedList;
  final Future<void> Function() loadMore;
  final ValueChanged<Circle> onTapCircle;
  final ValueChanged<Circle>? onTapFeed;

  static const _gap = Gap(12);

  @override
  Widget build(BuildContext context) {
    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;
    final padding = EdgeInsets.only(
      top: 8,
      left: 8,
      right: 8,
      bottom: bottomNavBarHeight,
    );

    return PicnicPagingListView<ChatMessagesFeed>(
      padding: padding,
      paginatedList: chatMessagesFeedList,
      loadMore: loadMore,
      loadingBuilder: (_) => const PicnicLoadingIndicator(),
      separatorBuilder: (BuildContext context, int index) => _gap,
      itemBuilder: (context, item) => FeedListItem(
        chatMessagesFeed: item,
        onTapCircle: onTapCircle,
        onTapFeed: onTapFeed,
      ),
    );
  }
}
