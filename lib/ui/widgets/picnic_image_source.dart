import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';

abstract class PicnicImageSource {
  //ignore: long-method
  factory PicnicImageSource.imageUrl(
    ImageUrl imageUrl, {
    BoxFit? fit,
    double? width,
    double? height,
    Color? color,
    TextStyle? emojiTextStyle,
    EdgeInsets? emojiPadding,
    double borderRadius = 0,
  }) {
    if (imageUrl.isEmoji) {
      assert(
        //ignore: prefer-trailing-comma
        [color, fit, width, height].every((it) => it == null),
        'color,fit,width,height must be null if setting up emoji image source',
      );
      return PicnicImageSource.emoji(
        imageUrl.url,
        style: emojiTextStyle,
        padding: emojiPadding,
      );
    } else if (imageUrl.isAsset) {
      assert(
        //ignore: prefer-trailing-comma
        [emojiTextStyle].every((it) => it == null),
        'emojiTextStyle must be null if setting up asset image source',
      );
      return PicnicImageSource.asset(
        imageUrl,
        fit: fit,
        width: width,
        height: height,
        color: color,
      );
    } else if (imageUrl.isFile) {
      assert(
        //ignore: prefer-trailing-comma
        [emojiTextStyle].every((it) => it == null),
        'emojiTextStyle must be null if setting up file image source',
      );
      return PicnicImageSource.file(
        File(imageUrl.url),
        fit: fit,
        width: width,
        height: height,
      );
    } else {
      assert(
        //ignore: prefer-trailing-comma
        [color, emojiTextStyle].every((it) => it == null),
        '[color, emojiTextStyle] must be null if setting up url image source',
      );
      return PicnicImageSource.url(
        imageUrl,
        fit: fit,
        width: width,
        height: height,
        borderRadius: borderRadius,
      );
    }
  }

  factory PicnicImageSource.url(
    ImageUrl url, {
    BoxFit? fit,
    double? width,
    double? height,
    double borderRadius = 0,
  }) =>
      UrlPicnicImageSource(
        url,
        width: width,
        height: height,
        fit: fit,
        borderRadius: borderRadius,
      );

  factory PicnicImageSource.asset(
    ImageUrl assetUrl, {
    BoxFit? fit,
    double? width,
    double? height,
    Color? color,
  }) {
    assert(
      assetUrl.url.isNotEmpty,
      'Asset imageSource cannot have empty path!',
    );
    return AssetPicnicImageSource(
      assetUrl,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }

  factory PicnicImageSource.file(
    File file, {
    BoxFit? fit,
    double? width,
    double? height,
    double borderRadius = 0,
  }) =>
      FilePicnicImageSource(
        file,
        width: width,
        height: height,
        fit: fit,
        borderRadius: borderRadius,
      );

  factory PicnicImageSource.emoji(
    String emoji, {
    TextStyle? style,
    EdgeInsets? padding,
  }) =>
      EmojiPicnicImageSource(
        emoji,
        style: style,
        padding: padding,
      );

  factory PicnicImageSource.memory(
    Uint8List data, {
    BoxFit? fit,
    double? width,
    double? height,
  }) =>
      MemoryPicnicImageSource(
        data,
        width: width,
        height: height,
        fit: fit,
      );

  PicnicImageSourceType get type;
}

extension PicnicImageSourceWhen on PicnicImageSource {
  // ignore: long-parameter-list
  T when<T>({
    required T Function(UrlPicnicImageSource source) url,
    required T Function(AssetPicnicImageSource source) asset,
    required T Function(EmojiPicnicImageSource source) emoji,
    required T Function(FilePicnicImageSource source) file,
    required T Function(MemoryPicnicImageSource source) memory,
  }) {
    switch (type) {
      case PicnicImageSourceType.url:
        return url(this as UrlPicnicImageSource);

      case PicnicImageSourceType.asset:
        return asset(this as AssetPicnicImageSource);

      case PicnicImageSourceType.emoji:
        return emoji(this as EmojiPicnicImageSource);

      case PicnicImageSourceType.file:
        return file(this as FilePicnicImageSource);

      case PicnicImageSourceType.memory:
        return memory(this as MemoryPicnicImageSource);
    }
  }
}

class UrlPicnicImageSource implements PicnicImageSource {
  UrlPicnicImageSource(
    this.url, {
    this.height,
    this.width,
    this.fit,
    this.borderRadius = 0,
  });

  final ImageUrl url;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final double borderRadius;

  @override
  PicnicImageSourceType get type => PicnicImageSourceType.url;
}

class AssetPicnicImageSource implements PicnicImageSource {
  AssetPicnicImageSource(
    this.assetUrl, {
    this.height,
    this.width,
    this.fit,
    this.color,
  });

  final ImageUrl assetUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  @override
  PicnicImageSourceType get type => PicnicImageSourceType.asset;
}

class FilePicnicImageSource implements PicnicImageSource {
  FilePicnicImageSource(
    this.file, {
    this.height,
    this.width,
    this.fit,
    this.borderRadius = 0,
  });

  final File file;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final double borderRadius;

  @override
  PicnicImageSourceType get type => PicnicImageSourceType.file;
}

class EmojiPicnicImageSource implements PicnicImageSource {
  EmojiPicnicImageSource(
    this.emoji, {
    this.style,
    this.padding,
  });

  final String emoji;
  final TextStyle? style;
  final EdgeInsets? padding;

  @override
  PicnicImageSourceType get type => PicnicImageSourceType.emoji;
}

class MemoryPicnicImageSource implements PicnicImageSource {
  const MemoryPicnicImageSource(
    this.data, {
    this.height,
    this.width,
    this.fit,
  });

  final Uint8List data;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  PicnicImageSourceType get type => PicnicImageSourceType.memory;
}

enum PicnicImageSourceType {
  url,
  asset,
  emoji,
  file,
  memory;
}
