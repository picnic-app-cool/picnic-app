import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/feed_type.dart';
import 'package:picnic_app/ui/widgets/top_navigation/feed_items_bar.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicTextBarUseCase extends WidgetbookComponent {
  PicnicTextBarUseCase()
      : super(
          name: '$FeedItemsBar',
          useCases: [
            WidgetbookUseCase(
              name: 'TextBar usecase',
              builder: (context) {
                return FeedItemsBar(
                  onTabChanged: (feed) {},
                  selectedFeed: const Feed.empty().copyWith(feedType: FeedType.custom),
                  tabs: context.knobs.options(
                    label: 'bar items',
                    options: [
                      Option<List<Feed>>(
                        label: 'three item',
                        value: [
                          const Feed.empty().copyWith(feedType: FeedType.custom),
                          const Feed.empty().copyWith(feedType: FeedType.circle),
                          const Feed.empty().copyWith(feedType: FeedType.explore),
                        ],
                      ),
                      Option<List<Feed>>(
                        label: 'four item',
                        value: [
                          const Feed.empty().copyWith(feedType: FeedType.custom),
                          const Feed.empty().copyWith(feedType: FeedType.circle),
                          const Feed.empty().copyWith(feedType: FeedType.explore),
                          const Feed.empty().copyWith(feedType: FeedType.slice),
                        ],
                      ),
                      Option<List<Feed>>(
                        label: 'three item',
                        value: [
                          const Feed.empty().copyWith(feedType: FeedType.custom),
                          const Feed.empty().copyWith(feedType: FeedType.circle),
                          const Feed.empty().copyWith(feedType: FeedType.explore),
                          const Feed.empty().copyWith(feedType: FeedType.slice),
                          const Feed.empty().copyWith(feedType: FeedType.user),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        );
}
