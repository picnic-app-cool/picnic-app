import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/empty_message_widget.dart';
import 'package:picnic_app/ui/widgets/paging_list/load_more_scroll_notification.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class CirclesList extends StatelessWidget {
  const CirclesList({
    Key? key,
    required this.userCircles,
    required this.onTapEnterCircle,
    required this.loadMore,
    required this.isLoading,
  }) : super(key: key);

  final PaginatedList<Circle> userCircles;
  final Function(Id) onTapEnterCircle;
  final Future<void> Function() loadMore;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return LoadMoreScrollNotification(
      emptyItems: userCircles.items.isEmpty,
      hasMore: userCircles.hasNextPage,
      loadMore: loadMore,
      builder: (context) {
        return CustomScrollView(
          slivers: [
            _CirclesList(
              onTapEnterCircle: onTapEnterCircle,
              userCircles: userCircles,
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

class _CirclesList extends StatelessWidget {
  const _CirclesList({
    Key? key,
    required this.userCircles,
    required this.onTapEnterCircle,
  }) : super(key: key);

  final PaginatedList<Circle> userCircles;
  final Function(Id) onTapEnterCircle;

  static const double _userCircleIconSize = 42;
  static const _height = 50.0;
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
          if (index < userCircles.items.length) {
            final circle = userCircles.items[index];
            return PicnicListItem(
              onTap: () => onTapEnterCircle(circle.id),
              height: _height,
              leftGap: 0,
              title: circle.name,
              titleTextOverflow: TextOverflow.ellipsis,
              titleStyle: textTheme.subtitle20.copyWith(
                color: shade900,
              ),
              leading: PicnicCircleAvatar(
                emoji: circle.emoji,
                image: circle.imageFile,
                avatarSize: _userCircleIconSize,
                emojiSize: _emojiSize,
                bgColor: colors.blackAndWhite.shade200,
              ),
            );
          } else {
            return EmptyMessageWidget(
              message: appLocalizations.emptyUserCirclesMessage,
            );
          }
        },
        childCount: userCircles.items.length,
      ),
    );
  }
}
