//ignore_for_file: avoid-returning-widgets
import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/ui/widgets/grouped_list/grouped_list_header_state.dart';

/// A groupable list of widgets similar to [ListView], except that the
/// items can be sectioned into groups.
class GroupedListView<T, E> extends StatefulWidget {
  const GroupedListView({
    super.key,
    required this.elements,
    required this.itemBuilder,
    required this.groupBy,
    required this.groupHeaderBuilder,
    this.loadingBuilder,
    this.useStickyGroupSeparators = true,
    this.separator = const SizedBox.shrink(),
    this.controller,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.reverse = false,
    this.clipBehavior = Clip.hardEdge,
  });

  /// Items of which [itemBuilder] produce the list.
  final List<T> elements;

  /// Defines which elements are grouped together.
  ///
  /// Function is called for each element in the list, when equal for two
  /// elements, those two belong to the same group.
  final E Function(T element) groupBy;

  /// Called to build group separators for each group.
  /// Value is always the groupBy result from the first element of the group.
  ///
  /// Will be ignored if [groupHeaderBuilder] is used.
  final Widget Function(E value) groupHeaderBuilder;

  /// Called to build children for the list with
  /// 0 <= element < elements.length.
  final Widget Function(BuildContext context, T element) itemBuilder;

  /// When set to true the group header of the current visible group will stick
  ///  on top.
  final bool useStickyGroupSeparators;

  /// Called to build separators for between each item in the list.
  final Widget separator;

  /// An object that can be used to control the position to which this scroll
  /// view is scrolled.
  ///
  /// See [ScrollView.controller]
  final ScrollController? controller;

  /// Called to build loading indicator in the end of the list. If null no loadingIndicator will be visible.
  final WidgetBuilder? loadingBuilder;

  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final bool reverse;
  final Clip clipBehavior;

  @override
  State<GroupedListView<T, E>> createState() => _GroupedListViewState<T, E>();
}

class _GroupedListViewState<T, E> extends State<GroupedListView<T, E>> {
  final LinkedHashMap<int, GlobalKey> _itemKeys = LinkedHashMap();
  final LinkedHashMap<int, GlobalKey> _groupKeys = LinkedHashMap();
  var _unvisibleGroups = <int>[];
  GlobalKey? _groupHeaderKey;
  double? _stickyHeaderPositionY;
  double? _stickyHeaderHeight;
  var _stickyHeaderState = const GroupedListHeaderState.empty();
  Timer? _headerVisibilityTimer;

  @override
  void dispose() {
    _headerVisibilityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elements = widget.elements;
    final itemCount = elements.length * 2;
    final groupBy = widget.groupBy;
    final hiddenIndex = widget.reverse ? elements.length * 2 - 1 : 0;
    final isSeparator = widget.reverse ? (int i) => i.isOdd : (int i) => i.isEven;

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: ListView.builder(
            key: widget.key,
            physics: widget.physics,
            shrinkWrap: widget.shrinkWrap,
            padding: widget.padding,
            reverse: widget.reverse,
            clipBehavior: widget.clipBehavior,
            itemCount: itemCount + (widget.loadingBuilder != null ? 1 : 0),
            itemBuilder: (context, index) {
              if (widget.loadingBuilder != null && index == itemCount) {
                return widget.loadingBuilder!(context);
              }
              final actualIndex = index ~/ 2;
              if (index == hiddenIndex) {
                return Opacity(
                  opacity: _unvisibleGroups.contains(actualIndex) ? 0 : 1,
                  child: _buildGroupSeparator(widget.groupBy(elements[actualIndex]), actualIndex),
                );
              }
              if (!isSeparator(index)) {
                return _buildItem(context, actualIndex);
              }
              final curr = groupBy(elements[actualIndex]);
              final prev = groupBy(elements[actualIndex + (widget.reverse ? 1 : -1)]);
              if (prev != curr) {
                return Opacity(
                  opacity: _unvisibleGroups.contains(actualIndex) ? 0 : 1,
                  child: _buildGroupSeparator(groupBy(elements[actualIndex]), actualIndex),
                );
              }
              return widget.separator;
            },
          ),
        ),
        Transform.translate(
          offset: Offset(0, _stickyHeaderState.offset),
          child: Opacity(
            opacity: _stickyHeaderState.isOutOfBounds ? 0 : 1,
            child: AnimatedOpacity(
              opacity: _stickyHeaderState.isVisible ? 1 : 0,
              duration: const ShortDuration(),
              child: _getStickyHeader(_stickyHeaderState.overlappedItem),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final key = _itemKeys.putIfAbsent(index, () => GlobalKey());
    final value = widget.elements[index];
    return KeyedSubtree(
      key: key,
      child: widget.itemBuilder(context, value),
    );
  }

  Widget _buildGroupSeparator(E groupElement, int index) {
    final key = _groupKeys.putIfAbsent(index, () => GlobalKey());
    return KeyedSubtree(
      key: key,
      child: widget.groupHeaderBuilder(groupElement),
    );
  }

  //ignore: long-method
  bool _handleScrollNotification(ScrollNotification notification) {
    if (_stickyHeaderHeight == null || _stickyHeaderPositionY == null) {
      final _headerBox = _groupHeaderKey?.currentContext?.findRenderObject() as RenderBox?;
      _stickyHeaderHeight ??= _headerBox?.size.height;
      _stickyHeaderPositionY ??= _headerBox?.localToGlobal(Offset.zero).dy;
    }

    if (_stickyHeaderHeight == null || _stickyHeaderPositionY == null) {
      return false;
    }

    var newStickyHeaderState = _stickyHeaderState;
    final newUnvisibleGroups = <int>[];

    _removeUnusedEntries(_itemKeys);
    _removeUnusedEntries(_groupKeys);

    newStickyHeaderState = newStickyHeaderState.copyWith(
      overlappedItem: _getCurrentOverlappingItem() ?? newStickyHeaderState.overlappedItem,
      isVisible: true,
    );

    final lastTopIndex = widget.reverse ? widget.elements.length - 1 : 0;
    var isOutOfBounds = false;
    var noOverlapGroupItems = true;
    final scrollPosition = notification.metrics.pixels;

    for (final entry in _groupKeys.entries) {
      final key = entry.value;
      final itemBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (itemBox == null) {
        continue;
      }
      final itemBoxHeight = itemBox.size.height;
      final itemY = itemBox.localToGlobal(Offset.zero).dy;
      if (itemY < _stickyHeaderPositionY! && newStickyHeaderState.isVisible) {
        newUnvisibleGroups.add(entry.key);
      }

      if (entry.key == lastTopIndex && _stickyHeaderPositionY! <= itemY) {
        isOutOfBounds = true;
      }

      final isOverlapping = itemY - _stickyHeaderPositionY! >= 0 && itemY - _stickyHeaderPositionY! <= itemBoxHeight;
      noOverlapGroupItems = noOverlapGroupItems && !isOverlapping;

      if (isOverlapping && newStickyHeaderState.overlappedGroupItem == -1) {
        final scrollOffset = _stickyHeaderHeight;
        final respectScrollOffset = (itemY - _stickyHeaderPositionY!) < itemBoxHeight / 2;

        newStickyHeaderState = newStickyHeaderState.copyWith(
          initialScrollPosition: scrollPosition,
          scrollOffset: scrollOffset,
          overlappedGroupItem: entry.key,
          respectScrollOffset: respectScrollOffset,
        );
      }
    }

    if (newStickyHeaderState.overlappedGroupItem != -1) {
      newStickyHeaderState = newStickyHeaderState.copyWith(
        scrollPosition: scrollPosition,
      );
    }

    if (noOverlapGroupItems) {
      newStickyHeaderState = newStickyHeaderState.copyWith(
        initialScrollPosition: 0,
        scrollPosition: 0,
        scrollOffset: 0,
        overlappedGroupItem: -1,
      );
    }

    newStickyHeaderState = newStickyHeaderState.copyWith(
      isOutOfBounds: isOutOfBounds,
    );

    if (mounted && !listEquals(_unvisibleGroups, newUnvisibleGroups)) {
      setState(() {
        _unvisibleGroups = newUnvisibleGroups;
      });
    }
    if (mounted && _stickyHeaderState != newStickyHeaderState) {
      setState(() {
        _stickyHeaderState = newStickyHeaderState;
      });
    }

    _headerVisibilityTimer?.cancel();
    _headerVisibilityTimer = Timer(const LongDuration(), _hideStickyHeader);

    return false;
  }

  int? _getCurrentOverlappingItem() {
    if (_stickyHeaderPositionY == null || _stickyHeaderHeight == null) {
      return null;
    }
    for (final entry in _itemKeys.entries) {
      final key = entry.value;

      final itemBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (itemBox == null) {
        continue;
      }

      final itemBoxHeight = itemBox.size.height;
      final itemY = itemBox.localToGlobal(Offset.zero).dy;

      final stickyHeaderTop = _stickyHeaderPositionY!;
      final stickyHeaderBottom = _stickyHeaderPositionY! + _stickyHeaderHeight!;

      final touchTop = stickyHeaderTop >= itemY && stickyHeaderTop <= itemY + itemBoxHeight;
      final touchBottom = stickyHeaderBottom >= itemY && stickyHeaderBottom <= itemY + itemBoxHeight;

      if (touchTop || touchBottom) {
        return entry.key;
      }
    }
    return null;
  }

  void _hideStickyHeader() {
    if (mounted) {
      setState(() {
        _unvisibleGroups = [];
        _stickyHeaderState = _stickyHeaderState.copyWith(
          isVisible: false,
        );
      });
    }
  }

  void _removeUnusedEntries(LinkedHashMap<int, GlobalKey> map) {
    _itemKeys.removeWhere((key, value) {
      RenderBox? itemBox;

      try {
        itemBox = value.currentContext!.findRenderObject()! as RenderBox;
      } catch (e) {
        doNothing();
      }

      if (itemBox == null || !itemBox.attached) {
        return true;
      }
      return false;
    });
  }

  Widget _getStickyHeader(int topElementIndex) {
    _groupHeaderKey = GlobalKey();
    final elements = widget.elements;
    if (widget.useStickyGroupSeparators && elements.isNotEmpty) {
      T topElement;

      try {
        topElement = elements[topElementIndex];
      } on Exception catch (_) {
        topElement = elements.first;
      }

      return Container(
        key: _groupHeaderKey,
        child: widget.groupHeaderBuilder(widget.groupBy(topElement)),
      );
    }
    return Container();
  }
}
