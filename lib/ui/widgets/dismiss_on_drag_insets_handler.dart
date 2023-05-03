import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:picnic_app/core/utils/scrollable_utils.dart';

class DismissOnDragInsetsHandler extends StatefulWidget {
  /// This handler updates [scrollController]'s offset on `bottomInsets` change.
  ///
  /// Designed to work with scrollables that have `keyboardDismissBehavior:` [ScrollViewKeyboardDismissBehavior.onDrag]
  ///
  /// [anchorKey] should be attached to the last element in ScrollView
  ///
  /// It scrolls the content up on keyboard open, so the bottom of the content will be
  /// raised along with the keyboard and will be visible.
  ///
  /// Two cases are handled here - when content does fit into Scrollable leaving extra blank space
  /// and when content does not fit.
  const DismissOnDragInsetsHandler({
    super.key,
    required this.anchorKey,
    required this.scrollController,
    required this.child,
    this.onKeyboardStatusChanged,
    this.keepVisibleOffset,
  });

  final GlobalKey anchorKey;
  final ScrollController scrollController;
  final void Function(bool isOpened)? onKeyboardStatusChanged;
  final double? keepVisibleOffset;
  final Widget child;

  @override
  State<DismissOnDragInsetsHandler> createState() => _DismissOnDragInsetsHandlerState();
}

class _DismissOnDragInsetsHandlerState extends State<DismissOnDragInsetsHandler> with WidgetsBindingObserver {
  late double _previousBottomInset;
  late bool _previousKeyboardOpened;

  double get _bottomInset =>
      WidgetsBinding.instance.window.viewInsets.bottom / WidgetsBinding.instance.window.devicePixelRatio;

  bool get _keyboardOpened => _bottomInset != 0;

  @override
  void initState() {
    super.initState();
    _previousBottomInset = _bottomInset;
    _previousKeyboardOpened = _keyboardOpened;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    _maybeNotifyKeyboardStatusChange();
    _handleBottomInsetsChange();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _handleBottomInsetsChange() {
    final bottomInset = _bottomInset;
    final bottomInsetDelta = bottomInset - _previousBottomInset;
    _previousBottomInset = bottomInset;

    if (widget.scrollController.positions.isEmpty || bottomInsetDelta <= 0) {
      return;
    }

    final position = widget.scrollController.position;
    final contentFits = position.maxScrollExtent == 0;

    if (contentFits) {
      final contentSize = _getScrollableContentSize();
      final viewportDimension = position.viewportDimension;
      final lackOfViewport = contentSize - viewportDimension;
      if (lackOfViewport > 0) {
        widget.scrollController.jumpTo(
          min(
            lackOfViewport,
            widget.keepVisibleOffset ?? double.infinity,
          ),
        );
      }
    } else {
      final estimatedOffset = widget.scrollController.offset + bottomInsetDelta;
      widget.scrollController.jumpTo(
        min(
          estimatedOffset,
          widget.keepVisibleOffset ?? double.infinity,
        ),
      );
    }
  }

  double _getScrollableContentSize() => getContextOffsetInScrollable(widget.anchorKey.currentContext!);

  void _maybeNotifyKeyboardStatusChange() {
    final keyboardOpened = _keyboardOpened;
    if (keyboardOpened != _previousKeyboardOpened) {
      _previousKeyboardOpened = keyboardOpened;
      widget.onKeyboardStatusChanged?.call(keyboardOpened);
    }
  }
}
