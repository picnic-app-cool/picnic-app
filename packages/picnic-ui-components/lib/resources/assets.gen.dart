/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/edit.webp
  AssetGenImage get edit => const AssetGenImage('assets/images/edit.webp');

  /// File path: assets/images/loader-icon.webp
  AssetGenImage get loaderIcon => const AssetGenImage('assets/images/loader-icon.webp');

  /// List of all assets
  List<AssetGenImage> get values => [edit, loaderIcon];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/button_like.json
  String get buttonLike => 'assets/lottie/button_like.json';

  /// File path: assets/lottie/glitter_effect.json
  String get glitterEffect => 'assets/lottie/glitter_effect.json';

  /// File path: assets/lottie/heartbeat.json
  String get heartbeat => 'assets/lottie/heartbeat.json';

  /// File path: assets/lottie/onboarding_background.json
  String get onboardingBackground => 'assets/lottie/onboarding_background.json';

  /// File path: assets/lottie/sound_attachment_playing.json
  String get soundAttachmentPlaying => 'assets/lottie/sound_attachment_playing.json';

  /// List of all assets
  List<String> get values => [buttonLike, glitterEffect, heartbeat, onboardingBackground, soundAttachmentPlaying];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
