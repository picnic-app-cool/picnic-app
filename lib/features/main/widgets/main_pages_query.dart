import 'package:flutter/material.dart';
import 'package:picnic_app/features/main/selected_tab_info.dart';

/// holds the value of the current selected main page status
class MainPagesQuery extends InheritedWidget {
  const MainPagesQuery({
    required super.child,
    required this.selectedTab,
  });

  final SelectedTabInfo selectedTab;

  static MainPagesQuery? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<MainPagesQuery>();

  @override
  bool updateShouldNotify(MainPagesQuery oldWidget) {
    return oldWidget.selectedTab != selectedTab;
  }
}
