import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FeedItemsBar extends StatefulWidget {
  const FeedItemsBar({
    super.key,
    required this.tabs,
    required this.onTabChanged,
    required this.selectedFeed,
    this.initialIndex = 0,
    this.titleColor,
    this.backgroundColor,
  });

  final List<Feed> tabs;

  final int initialIndex;
  final Color? titleColor;
  final Color? backgroundColor;
  final Function(Feed) onTabChanged;
  final Feed selectedFeed;

  @override
  State<FeedItemsBar> createState() => _FeedItemsBarState();
}

class _FeedItemsBarState extends State<FeedItemsBar> {
  static const _widgetHeight = 36.0;
  static const _borderRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    final feeds = widget.tabs;

    final theme = PicnicTheme.of(context);
    final titleStyle = theme.styles.body20.copyWith(color: widget.titleColor ?? theme.colors.blackAndWhite.shade100);

    final children = Map.fromEntries(
      feeds.map(
        (feed) {
          final isActive = feed == widget.selectedFeed;
          return MapEntry(
            feed,
            Text(
              feed.name,
              style: titleStyle.copyWith(
                fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                color: titleStyle.color?.withOpacity(
                  isActive ? Constants.fullOpacityValue : Constants.lowOpacityValue,
                ),
              ),
            ),
          );
        },
      ),
    );

    return SizedBox(
      height: _widgetHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSlidingSegmentedControl<Feed>(
            initialValue: widget.selectedFeed,
            height: _widgetHeight,
            children: children,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            thumbDecoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
            onValueChanged: widget.onTabChanged,
          ),
        ],
      ),
    );
  }
}
