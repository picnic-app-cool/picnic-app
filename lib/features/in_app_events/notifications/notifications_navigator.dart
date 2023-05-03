import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/fx_effect_overlay/fx_effect_route.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class NotificationsNavigator with NotificationsRoute, FxEffectRoute {
  NotificationsNavigator();
}

mixin NotificationsRoute {
  static const double _shadowOpacity = 0.05;
  static const double _blurRadius = 20;
  static const double _borderRadius = 16;
  static const int _durationSeconds = 5;

  Future<void> showInAppNotification({
    required String message,
    VoidCallback? onTap,
  }) {
    final context = AppNavigator.currentContext;

    final picnicTheme = PicnicTheme.of(context);
    final bwColor = picnicTheme.colors.blackAndWhite;

    return Flushbar(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      backgroundColor: bwColor.shade100,
      flushbarPosition: FlushbarPosition.TOP,
      boxShadows: [
        BoxShadow(
          color: bwColor.shade900.withOpacity(_shadowOpacity),
          offset: const Offset(0, 10),
          blurRadius: _blurRadius,
        ),
      ],
      borderRadius: BorderRadius.circular(_borderRadius),
      duration: const Duration(seconds: _durationSeconds),
      messageText: Text(
        message,
        style: picnicTheme.styles.body20.copyWith(
          color: bwColor.shade900,
        ),
        maxLines: 1,
      ),
      onTap: (_) {
        Navigator.of(context).pop();
        onTap?.call();
      },
    ).show(context);
  }
}
