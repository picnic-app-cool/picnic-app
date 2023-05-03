import 'package:flutter/widgets.dart';
import 'package:picnic_app/ui/widgets/picnic_toast/picnic_toast_controller.dart';

class PicnicToastTransition extends StatefulWidget {
  const PicnicToastTransition({
    super.key,
    required this.controller,
    required this.toast,
  });

  final Widget toast;
  final PicnicToastController controller;

  @override
  State<PicnicToastTransition> createState() => _PicnicToastTransitionState();
}

class _PicnicToastTransitionState extends State<PicnicToastTransition> with TickerProviderStateMixin {
  late final _openAnimationController = AnimationController(
    vsync: this,
    duration: widget.controller.openTransitionDuration,
  );

  late final _closeAnimationController = AnimationController(
    vsync: this,
    duration: widget.controller.closeTransitionDuration,
  );

  @override
  void initState() {
    super.initState();
    _openAnimationController.forward();
    widget.controller.register(onHide: _onHide);
  }

  @override
  Widget build(BuildContext context) {
    const toastBottomOffset = 100.0;

    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fill,
        end: const RelativeRect.fromLTRB(
          0,
          0,
          0,
          toastBottomOffset,
        ),
      ).animate(
        CurvedAnimation(
          parent: _openAnimationController,
          curve: Curves.easeOutQuad,
        ),
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: Tween<double>(begin: 1, end: 0).animate(_closeAnimationController),
          curve: Curves.easeOutQuad,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: widget.toast,
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.unregister(onHide: _onHide);
    _closeAnimationController.dispose();
    _openAnimationController.dispose();
    super.dispose();
  }

  Future<void> _onHide() async {
    await _closeAnimationController.forward();
  }
}
