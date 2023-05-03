import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/top_navigation/tabs/text_tab_item.dart';

const _spacing16 = 16.0;

class FeedItemsBar extends StatefulWidget {
  const FeedItemsBar({
    super.key,
    required this.tabs,
    required this.onTabChanged,
    required this.selectedFeed,
    this.onSeeMoreTap,
    this.initialIndex = 0,
    this.titleColor,
    this.showSeeMoreButton = false,
  });

  final List<Feed> tabs;

  final int initialIndex;
  final Color? titleColor;
  final Function(Feed) onTabChanged;
  final VoidCallback? onSeeMoreTap;
  final Feed selectedFeed;
  final bool showSeeMoreButton;

  @override
  State<FeedItemsBar> createState() => _FeedItemsBarState();
}

class _FeedItemsBarState extends State<FeedItemsBar> {
  final Map<Id, GlobalKey> _globalKeys = {};
  static const _spacing16 = 16.0;
  static const _alignment = 0.5;

  GlobalKey<State>? get _selectedGlobalKey => _globalKeys[widget.selectedFeed.id];

  @override
  void initState() {
    super.initState();
    _ensureGlobalKeys();
  }

  @override
  void didUpdateWidget(FeedItemsBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _ensureGlobalKeys();
    if (oldWidget.selectedFeed != widget.selectedFeed) {
      ///this makes sure we scroll to selected item when tab is changed
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _scrollToTab();
      });
    }
  }

  @override
  void dispose() {
    _globalKeys.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feeds = widget.tabs;
    //ignore: avoid-returning-widgets
    final tabsWidgets = _prepareTabs(feeds);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: _spacing16),
      child: Row(
        children: [
          ...tabsWidgets,
        ],
      ),
    );
  }

  void _scrollToTab() {
    final itemContext = _selectedGlobalKey?.currentContext;
    if (itemContext != null) {
      Scrollable.ensureVisible(
        itemContext,
        duration: const LongDuration(),
        curve: Curves.easeOutCirc,
        alignment: _alignment,
        // alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      );
    }
  }

  void _ensureGlobalKeys() {
    for (final tab in widget.tabs) {
      _globalKeys[tab.id] ??= GlobalKey(debugLabel: tab.name);
    }
  }

  List<_FeedItemBarElement> _prepareTabs(List<Feed> feeds) {
    final shouldShowMoreButton = widget.showSeeMoreButton;
    final tabsWidgets = feeds.map((tab) {
      final selected = widget.selectedFeed == tab;
      return _FeedItemBarElement(
        onTabChanged: () => widget.onTabChanged(tab),
        title: tab.name,
        isSelected: selected,
        subtreeKey: ValueKey("${tab.id}${widget.titleColor}"),
        titleColor: widget.titleColor,
        selectedKey: _globalKeys[tab.id],
      );
    }).toList();

    if (shouldShowMoreButton) {
      final showMoreButton = _FeedItemBarElement(
        onTabChanged: () => widget.onSeeMoreTap?.call(),
        title: appLocalizations.feedSeeMoreButton,
        isSelected: false,
        titleColor: widget.titleColor,
      );
      tabsWidgets.insert(min(tabsWidgets.length, 1), showMoreButton);
    }
    return tabsWidgets;
  }
}

class _FeedItemBarElement extends StatelessWidget {
  const _FeedItemBarElement({
    Key? key,
    this.titleColor,
    required this.onTabChanged,
    this.subtreeKey,
    this.selectedKey,
    required this.title,
    required this.isSelected,
  }) : super(key: key);

  final Color? titleColor;
  final Function() onTabChanged;
  final Key? subtreeKey;
  final Key? selectedKey;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: _spacing16),
      child: AnimatedSwitcher(
        duration: const MediumDuration(),
        child: KeyedSubtree(
          key: subtreeKey,
          child: TextTabItem(
            key: isSelected ? selectedKey : null,
            onTap: onTabChanged,
            title: title,
            isActive: isSelected,
            titleColor: titleColor,
          ),
        ),
      ),
    );
  }
}
