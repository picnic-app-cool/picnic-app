import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class PicnicLikeButton extends StatefulWidget {
  const PicnicLikeButton({
    Key? key,
    required this.isLiked,
    required this.onTap,
    required this.size,
    this.strokeColor,
    this.image,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final bool isLiked;
  final double size;
  final EdgeInsets padding;
  final Color? strokeColor;
  final VoidCallback? onTap;
  final AssetGenImage? image;

  @override
  State<PicnicLikeButton> createState() => _PicnicLikeButtonState();
}

class _PicnicLikeButtonState extends State<PicnicLikeButton> with TickerProviderStateMixin {
  late final AnimationController _controller;

  static const _animationSizeMultiplier = 2.6;

  double get _lottieSize => widget.size * _animationSizeMultiplier;

  @override
  void didUpdateWidget(PicnicLikeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLiked == oldWidget.isLiked) {
      return;
    }

    if (widget.isLiked) {
      _controller.forward();
    } else {
      _controller.reset();
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: widget.padding,
          child: SizedOverflowBox(
            size: Size(widget.size, widget.size),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: widget.isLiked ? 1 : 0,
                  child: Lottie.asset(
                    Assets.lottie.buttonLike,
                    controller: _controller,
                    repeat: false,
                    animate: false,
                    onLoaded: _moveAnimationToState,
                    width: _lottieSize,
                    height: _lottieSize,
                    onWarning: (warning) {
                      logError(warning, logToCrashlytics: false);
                    },
                  ),
                ),
                if (!widget.isLiked)
                  Center(
                    child: (widget.image ?? Assets.images.heartOutlined).image(
                      fit: BoxFit.cover,
                      color: widget.strokeColor,
                      width: widget.size,
                      height: widget.size,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );

  void _moveAnimationToState(LottieComposition composition) {
    _controller.duration = composition.duration;

    if (widget.isLiked) {
      _controller.animateTo(
        composition.durationFrames,
        duration: Duration.zero,
      );
    }
  }
}
