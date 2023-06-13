import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/empty_message_widget.dart';
import 'package:picnic_app/ui/widgets/paging_list/load_more_scroll_notification.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PodList extends StatelessWidget {
  const PodList({
    Key? key,
    required this.pods,
    required this.loadMore,
    required this.isLoading,
  }) : super(key: key);

  final PaginatedList<PodApp> pods;
  final Future<void> Function() loadMore;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return LoadMoreScrollNotification(
      emptyItems: pods.items.isEmpty,
      hasMore: pods.hasNextPage,
      loadMore: loadMore,
      builder: (context) {
        return CustomScrollView(
          slivers: [
            _PodsList(
              pods: pods,
            ),
            const SliverToBoxAdapter(
              child: Gap(8),
            ),
            const SliverToBoxAdapter(
              child: Gap(8),
            ),
            if (isLoading)
              const SliverFillRemaining(
                child: Center(
                  child: PicnicLoadingIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _PodsList extends StatelessWidget {
  const _PodsList({
    Key? key,
    required this.pods,
  }) : super(key: key);

  final PaginatedList<PodApp> pods;

  static const double _userCircleIconSize = 42;
  static const _height = 48.0;
  static const _emojiSize = 22.0;

  @override
  Widget build(BuildContext context) {
    final picnicTheme = PicnicTheme.of(context);

    final colors = picnicTheme.colors;
    final textTheme = picnicTheme.styles;

    final shade900 = colors.blackAndWhite.shade900;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < pods.items.length) {
            final pod = pods.items[index];
            return PicnicListItem(
              height: _height,
              leftGap: 0,
              title: pod.name,
              titleTextOverflow: TextOverflow.ellipsis,
              titleStyle: textTheme.subtitle20.copyWith(
                color: shade900,
              ),
              leading: PicnicCircleAvatar(
                image: pod.imageUrl,
                avatarSize: _userCircleIconSize,
                emojiSize: _emojiSize,
                bgColor: colors.blackAndWhite.shade200,
              ),
            );
          } else {
            return EmptyMessageWidget(
              message: appLocalizations.emptyUserPodsMessage,
            );
          }
        },
        childCount: pods.items.length,
      ),
    );
  }
}
