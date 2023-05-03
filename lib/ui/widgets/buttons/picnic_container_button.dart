import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_badge.dart';

class PicnicContainerButton extends StatelessWidget {
  const PicnicContainerButton({
    Key? key,
    this.onTap,
    this.buttonColor,
    this.height,
    this.width,
    this.radius,
    this.padding,
    this.backdropFilter,
    this.badgeValue,
    required this.child,
  }) : super(key: key);

  final VoidCallback? onTap;

  final Color? buttonColor;

  final double? height;
  final double? width;

  final double? radius;
  final double? padding;

  ///If [backdropFilter] is not null, the [buttonColor] should have
  ///an opacity to see the results.
  final ImageFilter? backdropFilter;

  static const double buttonSize = 48;
  final Widget child;

  final int? badgeValue;

  @override
  Widget build(BuildContext context) {
    final heightConstraint = height != null && height! < buttonSize ? height! : buttonSize;
    final widthConstraint = width != null && width! < buttonSize ? width! : buttonSize;
    final _radius = BorderRadius.circular(radius ?? Constants.borderRadiusML);
    final _filter = backdropFilter;
    final _childWrapper = Material(
      color: buttonColor ?? PicnicColors.primaryButtonBlue,
      borderRadius: _radius,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: heightConstraint,
          minHeight: widthConstraint,
          maxHeight: height ?? double.infinity,
          maxWidth: width ?? double.infinity,
        ),
        child: InkWell(
          borderRadius: _radius,
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(padding ?? Constants.lowPadding),
                child: child,
              ),
              _Badge(
                badgeValue: badgeValue,
                height: heightConstraint,
                width: widthConstraint,
              ),
            ],
          ),
        ),
      ),
    );

    return ClipRRect(
      borderRadius: _radius,
      child: _filter != null
          ? BackdropFilter(
              filter: _filter,
              child: _childWrapper,
            )
          : _childWrapper,
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    Key? key,
    required this.badgeValue,
    required this.height,
    required this.width,
  }) : super(key: key);

  final int? badgeValue;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (badgeValue != null && badgeValue != 0) {
      const halfFraction = 2.0;

      return Positioned(
        bottom: height / halfFraction,
        left: width / halfFraction,
        child: PicnicBadge(count: badgeValue ?? 0),
      );
    }
    return const SizedBox.shrink();
  }
}
