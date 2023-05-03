import 'package:flutter/material.dart';

/// holds the value of the child bottom navigation, but only if its being reported by:
/// BottomNavigationSizeQuery.updateSize(context, newSize) from within any descendant [child]
class BottomNavigationSizeQuery extends StatefulWidget {
  const BottomNavigationSizeQuery({
    super.key,
    required this.child,
  });

  final Widget child;

  static Size of(BuildContext context) => _BottomNavigationSizeQueryInherited.of(context);

  static void updateSize(BuildContext context, Size size) => _state(context)?.updateSize(size);

  @override
  State<BottomNavigationSizeQuery> createState() => _BottomNavigationSizeQueryState();

  static _BottomNavigationSizeQueryState? _state(BuildContext context) =>
      context.findAncestorStateOfType<_BottomNavigationSizeQueryState>();
}

class _BottomNavigationSizeQueryState extends State<BottomNavigationSizeQuery> {
  Size size = Size.zero;

  @override
  Widget build(BuildContext context) => _BottomNavigationSizeQueryInherited(
        size: size,
        child: widget.child,
      );

  void updateSize(Size size) => setState(() => this.size = size);
}

class _BottomNavigationSizeQueryInherited extends InheritedWidget {
  const _BottomNavigationSizeQueryInherited({
    required super.child,
    required this.size,
  });

  final Size size;

  static Size of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<_BottomNavigationSizeQueryInherited>();
    return result?.size ?? Size.zero;
  }

  @override
  bool updateShouldNotify(_BottomNavigationSizeQueryInherited oldWidget) {
    return oldWidget.size != size;
  }
}
