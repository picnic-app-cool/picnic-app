import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';

const _displayDuration = Duration(seconds: 2);

class PicnicVideoPlayerMuteSwitchButton extends StatefulWidget {
  const PicnicVideoPlayerMuteSwitchButton({
    super.key,
    required this.videoLastTappedAt,
    required this.onTap,
    required this.muted,
  });

  final DateTime? videoLastTappedAt;
  final VoidCallback onTap;
  final bool muted;

  @override
  State<PicnicVideoPlayerMuteSwitchButton> createState() => PicnicVideoPlayerMuteSwitchButtonState();
}

class PicnicVideoPlayerMuteSwitchButtonState extends State<PicnicVideoPlayerMuteSwitchButton>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const ShortDuration(),
  );

  Timer? _hideButtonTimer;

  @override
  void didUpdateWidget(covariant PicnicVideoPlayerMuteSwitchButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoLastTappedAt != widget.videoLastTappedAt) {
      _display();
    }
  }

  @override
  Widget build(BuildContext context) {
    const buttonSize = 40.0;
    const iconSize = 16.0;

    return FadeTransition(
      opacity: CurveTween(curve: Curves.easeOutQuad).animate(_animationController),
      child: PicnicIconButton(
        icon: widget.muted ? Assets.images.volumeX.path : Assets.images.volume2.path,
        size: buttonSize,
        iconSize: iconSize,
        style: PicnicIconButtonStyle.blurred,
        onTap: _onTap,
      ),
    );
  }

  @override
  void dispose() {
    _hideButtonTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _display() {
    _hideButtonTimer?.cancel();
    _animationController.forward();
    _hideButtonTimer = Timer(_displayDuration, _hide);
  }

  void _hide() {
    _hideButtonTimer?.cancel();
    _animationController.reverse();
  }

  void _onTap() {
    widget.onTap();
    // prolong display time
    _display();
  }
}
