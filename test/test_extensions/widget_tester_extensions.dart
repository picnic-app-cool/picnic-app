import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

extension WidgetTesterExtensions on WidgetTester {
  Future<void> setupWidget(Widget widget) {
    return pumpWidget(
      MaterialApp(
        home: PicnicTheme(child: widget),
      ),
    );
  }
}
