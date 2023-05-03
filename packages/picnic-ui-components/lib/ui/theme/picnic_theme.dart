import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme_data.dart';

class PicnicTheme extends StatefulWidget {
  const PicnicTheme({
    ///useful for UI tests
    this.phoneSizeOverride,
    super.key,
    required this.child,
  });

  final Size? phoneSizeOverride;
  final Widget child;

  static PicnicThemeData of(BuildContext context) {
    final state = context.findAncestorStateOfType<_PicnicThemeState>();

    assert(state != null, 'No PicnicTheme found in context');
    return state!.data ??= PicnicThemeData(_screenLogicalSize(state.phoneSizeOverride));
  }

  @override
  State<PicnicTheme> createState() => _PicnicThemeState();

  static Size _screenLogicalSize(Size? phoneSizeOverride) {
    if (phoneSizeOverride != null) {
      return phoneSizeOverride;
    }
    final window = WidgetsBinding.instance.window;
    final pixelRatio = window.devicePixelRatio;

    return window.physicalSize / pixelRatio;
  }
}

class _PicnicThemeState extends State<PicnicTheme> {
  PicnicThemeData? data;

  Size? get phoneSizeOverride => widget.phoneSizeOverride;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
