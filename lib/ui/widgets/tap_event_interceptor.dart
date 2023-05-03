import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// wraps the layout with hit testing widget that triggers the given method on tapping while also sending the tap
/// event down the widget tree so other widgets can also handle their own tap
class TapEventInterceptor extends SingleChildRenderObjectWidget {
  const TapEventInterceptor({
    super.key,
    required this.onTap,
    required super.child,
  });

  final VoidCallback onTap;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _PassTroughHitsRenderObject(
      onHit: onTap,
    );
  }
}

class _PassTroughHitsRenderObject extends RenderProxyBoxWithHitTestBehavior {
  _PassTroughHitsRenderObject({required this.onHit});

  final VoidCallback onHit;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final hit = super.hitTest(result, position: position);
    onHit.call();
    return hit;
  }
}
