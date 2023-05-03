import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:picnic_app/ui/widgets/automatic_keyboard_hide.dart';

/// specifes ignore area for [AutomaticKeyboardHide] widget
class IgnoreAutomaticKeyboardHide extends SingleChildRenderObjectWidget {
  const IgnoreAutomaticKeyboardHide({
    super.key,
    required Widget child,
    this.behavior = HitTestBehavior.deferToChild,
  }) : super(child: child);

  final HitTestBehavior behavior;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return IgnoreAutomaticKeyboardHideRenderObject(behavior: behavior);
  }
}

class IgnoreAutomaticKeyboardHideRenderObject extends RenderProxyBoxWithHitTestBehavior {
  IgnoreAutomaticKeyboardHideRenderObject({super.behavior});
}
