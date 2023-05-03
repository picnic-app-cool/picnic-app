import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:picnic_app/ui/widgets/ignore_automatic_keyboard_hide.dart';

/// wraps the layout with hit testing widget that hides keyboard on any interaction with the screen that happens
/// outside of soft keyboard. all pointer events are passed trough to underlying children and this widget is completely
/// transparent from the touch perspective
class AutomaticKeyboardHide extends SingleChildRenderObjectWidget {
  const AutomaticKeyboardHide({
    super.key,
    required super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _PassTroughHitsRenderObject(
      onHit: () => FocusScope.of(context).unfocus(),
    );
  }
}

class _PassTroughHitsRenderObject extends RenderProxyBoxWithHitTestBehavior {
  _PassTroughHitsRenderObject({required this.onHit});

  final VoidCallback onHit;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final hited = super.hitTest(result, position: position);
    final hittedIgnoreArea = result.path.any((e) => e.target is IgnoreAutomaticKeyboardHideRenderObject);
    if (!hittedIgnoreArea) {
      onHit();
    }
    return hited;
  }
}
