import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';

class NotificationsListTrailingImage extends StatelessWidget {
  const NotificationsListTrailingImage(this.url);

  final String url;

  static const _imageSize = Size(32.0, 32.0);
  static const _cornerRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_cornerRadius),
      child: PicnicImage(
        source: PicnicImageSource.url(
          ImageUrl(url),
          fit: BoxFit.cover,
          width: _imageSize.width,
          height: _imageSize.height,
        ),
      ),
    );
  }
}
