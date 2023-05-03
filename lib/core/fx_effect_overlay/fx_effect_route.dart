import 'package:flutter/material.dart';
import 'package:picnic_app/core/fx_effect_overlay/fx_effect.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

mixin FxEffectRoute {
  Future<void> showFxEffect(FxEffect fxEffect) async {
    // ignore: invalid_use_of_protected_member
    final ctx = AppNavigator.navigatorKey;

    final overlayState = ctx.currentState?.overlay;
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return IgnorePointer(
          child: fxEffect.build(context),
        );
      },
    );
    overlayState?.insert(overlayEntry);

    await Future.delayed(fxEffect.duration);

    overlayEntry.remove();
  }
}
