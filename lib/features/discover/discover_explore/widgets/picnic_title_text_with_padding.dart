import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicTitleTextWithPadding extends StatelessWidget {
  const PicnicTitleTextWithPadding({
    Key? key,
    this.bottomPadding,
    this.topPadding,
    required this.text,
  }) : super(key: key);

  final String text;

  final double? bottomPadding;
  final double? topPadding;

  static const _highPadding = 24.0;
  static const _lowPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    final styles = PicnicTheme.of(context).styles;

    // The reason I used Padding implicitly here and don't wrap the whole body of CustomScrollView
    // is that I had to use the native Padding for the ListViews to have a better scroll towards to edges
    return Padding(
      padding: EdgeInsets.fromLTRB(
        _highPadding,
        topPadding ?? _lowPadding,
        _highPadding,
        bottomPadding ?? _lowPadding,
      ),
      child: Text(text, style: styles.subtitle40),
    );
  }
}
