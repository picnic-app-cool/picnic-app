import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/utils/defer_pointer/defer_pointer.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

/// Fully customizable [PicnicAvatar]
///
/// The [borderColor] overrides [borderImage]
///
/// If you want an image as a border, [borderImage] should contain the image path and [borderColor] should be empty
/// [backgroundColor] works as a background on the [PicnicImageSource] only, [backgroundImage] fills up the whole avatar and
/// overrides [PicnicImageSource] and [backgroundColor]
///
/// Everything else is relative to [size] and keeps itself responsive accordingly
///
/// To expand the [PicnicImageSource] param across the entire PicnicAvatar without having padding around it,
/// introduce [PicnicAvatarChildBoxFit.cover] to [boxFit] param. Be sure to specify the dimensions W and H of the Image (image.asset or image.network) equal to the [size]
///

class PicnicAvatar extends StatefulWidget {
  PicnicAvatar({
    Key? key,
    required PicnicImageSource imageSource,
    this.borderColor,
    this.backgroundColor,
    this.borderImage = const ImageUrl.empty(),
    this.verificationBadgeImage = const ImageUrl.empty(),
    this.backgroundImage = const ImageUrl.empty(),
    this.onTap,
    this.onToggleFollow,
    this.size = _defaultSize,
    this.iFollow = true,
    this.isCrowned = false,
    this.isVerified = false,
    this.showShadow = false,
    this.followButtonBackgroundColor,
    this.followButtonForegroundColor,
    this.placeholder,
    this.boxFit = PicnicAvatarChildBoxFit.fit,
    this.borderPercentage = defaultBorderPercentage,
    this.deferredLink,
  })  : _imageSource = imageSource,
        super(key: key != null ? ValueKey(imageSource.hashCode) : null);

  final double size;
  final bool iFollow;
  final bool isCrowned;
  final bool isVerified;

  final Color? borderColor;
  final double borderPercentage;
  final Color? backgroundColor;
  final Color? followButtonBackgroundColor;
  final Color? followButtonForegroundColor;
  final Widget Function()? placeholder;

  final ImageUrl borderImage;
  final ImageUrl verificationBadgeImage;

  final ImageUrl backgroundImage;
  final bool showShadow;
  final VoidCallback? onTap;
  final VoidCallback? onToggleFollow;
  final PicnicAvatarChildBoxFit boxFit;
  final DeferredPointerHandlerLink? deferredLink;
  static const defaultBorderPercentage = 0.1;

  final PicnicImageSource _imageSource;

  static const _defaultSize = 100.0;
  static const _addIconRadiusRatio = 0.20;
  static const _crownSizeRatio = 0.4;
  static const _rotationAngle = 0.15;
  static const _shadowBlurRadius = 20.0;
  static const _shadowOpacity = 0.07;
  static const _shadowOffset = Offset(0, 16);

  @override
  State<PicnicAvatar> createState() => _PicnicAvatarState();
}

class _PicnicAvatarState extends State<PicnicAvatar> {
  late bool _showFollowButton;

  @override
  void initState() {
    super.initState();
    _showFollowButton = !widget.iFollow;
  }

  @override
  void didUpdateWidget(covariant PicnicAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.iFollow == oldWidget.iFollow) {
      return;
    }
    if (!widget.iFollow) {
      setState(() {
        _showFollowButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: _shadow(),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            if (widget.isCrowned) _Crown(size: widget.size),
            Align(
              child: _ImageWithBorder(
                size: widget.size,
                backgroundColor: widget.backgroundColor,
                backgroundImage: widget.backgroundImage,
                borderColor: widget.borderColor,
                borderImage: widget.borderImage,
                borderPercentage: widget.borderPercentage,
                boxFit: widget.boxFit,
                child: PicnicImage(
                  source: widget._imageSource,
                  placeholder: widget.placeholder,
                ),
              ),
            ),
            if (_showFollowButton)
              _FollowButton(
                size: widget.size,
                onToggleFollow: widget.onToggleFollow,
                iFollow: widget.iFollow,
                followButtonForegroundColor: widget.followButtonForegroundColor,
                followButtonBackgroundColor: widget.followButtonBackgroundColor,
                deferredLink: widget.deferredLink,
              ),
            if (widget.isVerified)
              _VerificationBadge(
                size: widget.size,
                badgeUrl: widget.verificationBadgeImage,
              ),
          ],
        ),
      ),
    );
  }

  BoxDecoration? _shadow() {
    return widget.showShadow
        ? BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: PicnicAvatar._shadowOffset,
                color: Colors.black.withOpacity(PicnicAvatar._shadowOpacity),
                blurRadius: PicnicAvatar._shadowBlurRadius,
              ),
            ],
          )
        : null;
  }
}

class _ImageWithBorder extends StatelessWidget {
  const _ImageWithBorder({
    required this.size,
    required this.backgroundColor,
    required this.backgroundImage,
    required this.borderColor,
    required this.borderImage,
    required this.child,
    required this.boxFit,
    required this.borderPercentage,
  });

  final double size;
  final Color? backgroundColor;
  final ImageUrl backgroundImage;
  final Color? borderColor;
  final ImageUrl borderImage;
  final Widget? child;
  final PicnicAvatarChildBoxFit boxFit;
  final double borderPercentage;

  @override
  Widget build(BuildContext context) {
    final hasBorderImage = borderImage != const ImageUrl.empty();
    final hasBorder = borderColor != null || hasBorderImage;
    final _bgColor = backgroundImage == const ImageUrl.empty()
        ? (backgroundColor ?? PicnicTheme.of(context).colors.lightBlue)
        : null;
    final borderInset = hasBorder ? EdgeInsets.all(size * borderPercentage) : EdgeInsets.zero;
    final imagePadding = EdgeInsets.all(size * 0.2);
    return ClipOval(
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (hasBorderImage) Image.asset(borderImage.url),
          if (borderColor != null)
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: borderColor,
              ),
            ),
          if (backgroundImage != const ImageUrl.empty())
            Padding(
              padding: borderInset,
              child: Image.asset(
                backgroundImage.url,
              ),
            ),
          if (_bgColor != null)
            Padding(
              padding: borderInset,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _bgColor,
                ),
              ),
            ),
          if (child != null)
            Positioned.fill(
              child: Padding(
                padding: boxFit == PicnicAvatarChildBoxFit.fit ? imagePadding : EdgeInsets.zero,
                child: child,
              ),
            ),
        ],
      ),
    );
  }
}

class _FollowButton extends StatefulWidget {
  const _FollowButton({
    required this.size,
    required this.onToggleFollow,
    required this.iFollow,
    this.followButtonForegroundColor,
    this.followButtonBackgroundColor,
    this.deferredLink,
  });

  final double size;
  final VoidCallback? onToggleFollow;
  final bool iFollow;
  final Color? followButtonBackgroundColor;
  final Color? followButtonForegroundColor;
  final DeferredPointerHandlerLink? deferredLink;

  @override
  State<_FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<_FollowButton> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void didUpdateWidget(_FollowButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.iFollow == oldWidget.iFollow) {
      return;
    }
    if (widget.iFollow) {
      _controller.forward();
    } else {
      _controller.reverse();
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
  Widget build(BuildContext context) {
    final dx = widget.size / 2;
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: Transform.translate(
        offset: Offset(dx, widget.size),
        child: DeferPointer(
          paintOnTop: true,
          link: widget.deferredLink,
          child: SizedBox(
            width: widget.size,
            child: InkWell(
              onTap: widget.iFollow ? null : widget.onToggleFollow,
              child: CircleAvatar(
                maxRadius: widget.size * PicnicAvatar._addIconRadiusRatio,
                minRadius: widget.size * PicnicAvatar._addIconRadiusRatio,
                backgroundColor:
                    widget.followButtonBackgroundColor ?? PicnicTheme.of(context).colors.blackAndWhite.shade100,
                foregroundColor: widget.followButtonForegroundColor,
                child: Padding(
                  // ignore: no-magic-number
                  padding: EdgeInsets.all(widget.size * 0.025),
                  child: Lottie.asset(
                    Assets.lottie.checkAnimation,
                    controller: _controller,
                    repeat: false,
                    animate: false,
                    onLoaded: _moveAnimationToState,
                    delegates: LottieDelegates(
                      values: [
                        if (widget.followButtonForegroundColor != null)
                          ValueDelegate.colorFilter(
                            ['Add_Added', '**'],
                            value: ColorFilter.mode(widget.followButtonForegroundColor!, BlendMode.src),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _moveAnimationToState(LottieComposition composition) {
    _controller.duration = composition.duration;

    if (widget.iFollow) {
      _controller.animateTo(
        composition.durationFrames,
        duration: Duration.zero,
      );
    }
  }
}

class _Crown extends StatelessWidget {
  const _Crown({
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(
        -PicnicAvatar._crownSizeRatio,
        -PicnicAvatar._crownSizeRatio,
      ),
      child: Transform.rotate(
        angle: PicnicAvatar._rotationAngle,
        child: Image.asset(
          Assets.images.crown.path,
          height: size * PicnicAvatar._crownSizeRatio,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _VerificationBadge extends StatelessWidget {
  const _VerificationBadge({
    required this.size,
    required this.badgeUrl,
  });

  final double size;
  final ImageUrl badgeUrl;
  static const _badgeRatio = 0.4;

  @override
  Widget build(BuildContext context) {
    var badge = badgeUrl;
    if (badge == const ImageUrl.empty()) {
      badge = ImageUrl(Assets.images.verificationBadgePink.path);
    }

    return SizedBox(
      width: size,
      height: size,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Image.asset(badge.url, width: size * _badgeRatio),
      ),
    );
  }
}

enum PicnicAvatarChildBoxFit { fit, cover }
