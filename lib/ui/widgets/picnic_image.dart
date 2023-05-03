import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/main.dart';
import 'package:picnic_app/ui/widgets/double_tap_detector.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';

class PicnicImage extends StatelessWidget {
  const PicnicImage({
    super.key,
    required PicnicImageSource source,
    this.placeholder,
    this.alignEmoji = true,
    this.onDoubleTap,
    this.onTap,
  }) : _source = source;

  final Widget Function()? placeholder;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onTap;
  final bool alignEmoji;
  final PicnicImageSource _source;

  @override
  Widget build(BuildContext context) {
    return _source.when(
      url: (source) {
        Widget placeholderWidget() => SizedBox(
              width: source.width,
              height: source.height,
              child: placeholder?.call(),
            );

        return isUnitTests
            ? placeholderWidget()
            : DoubleTapDetector(
                onDoubleTap: () => onDoubleTap?.call(),
                child: CachedNetworkImage(
                  imageUrl: source.url.url,
                  width: source.width,
                  height: source.height,
                  fit: source.fit,
                  placeholder: (_, __) => placeholderWidget(),
                  errorWidget: (
                    _,
                    __,
                    ___,
                  ) =>
                      placeholderWidget(),
                ),
              );
      },
      asset: (source) => Image.asset(
        source.assetUrl.url,
        width: source.width,
        height: source.height,
        fit: source.fit,
        color: source.color,
      ),
      emoji: (source) {
        if (source.emoji.isEmpty) {
          return placeholder?.call() ?? const SizedBox.shrink();
        }
        return Center(
          child: Padding(
            padding: source.padding ?? EdgeInsets.zero,
            child: Text(
              source.emoji,
              textAlign: TextAlign.center,
              style: (source.style ?? const TextStyle()).copyWith(
                fontFeatures: [
                  // this makes sure emoji is centered correctly inside the Text widget
                  FontFeature.disable(const FontFeature.superscripts().feature),
                ],
              ),
            ),
          ),
        );
      },
      file: (source) => ClipRRect(
        borderRadius: BorderRadius.circular(source.borderRadius),
        child: Image.file(
          source.file,
          width: source.width,
          height: source.height,
          fit: source.fit,
        ),
      ),
      memory: (source) => Image.memory(
        source.data,
        width: source.width,
        height: source.height,
        fit: source.fit,
      ),
    );
  }
}
