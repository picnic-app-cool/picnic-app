//ignore_for_file: unused-code
//ignore_for_file: unused-files
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class PicnicBlurredImage extends StatelessWidget {
  const PicnicBlurredImage({
    super.key,
    required this.imageUrl,
    required this.isBlurred,
    required this.onTapUnblur,
    this.iconPath,
    this.iconColor,
    this.borderRadius,
    this.height,
    this.showIconSize = _iconSize,
  })  : showIconBackgroundSize = showIconSize + showIconSize,
        _imageBlur = isBlurred ? _defaultBlurRadius : 0.0,
        _showIconOpacity = isBlurred ? 1.0 : 0.0;

  final String imageUrl;
  final bool isBlurred;
  final VoidCallback onTapUnblur;
  final double? height;
  final double? borderRadius;
  final String? iconPath;
  final Color? iconColor;
  final double showIconSize;

  final double showIconBackgroundSize;
  static const _iconSize = 24.0;

  static const _defaultBlurRadius = 16.0;
  static const _iconBackgroundColorOpacity = 0.1;
  static const _showImageDurationInMilliSeconds = 300;

  final double _imageBlur;
  final double _showIconOpacity;

  @override
  Widget build(BuildContext context) {
    final iconPath = this.iconPath ?? Assets.images.show.path;
    final iconColor = this.iconColor ?? Colors.white;

    return ClipRRect(
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: _imageBlur,
                  sigmaY: _imageBlur,
                ),
                child: Container(),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(microseconds: _showImageDurationInMilliSeconds),
            opacity: _showIconOpacity,
            child: Align(
              child: InkWell(
                onTap: onTapUnblur,
                child: Container(
                  width: showIconBackgroundSize,
                  height: showIconBackgroundSize,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(_iconBackgroundColorOpacity),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    iconPath,
                    width: showIconSize,
                    color: iconColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
