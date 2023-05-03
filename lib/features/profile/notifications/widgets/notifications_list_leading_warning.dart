import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';

class NotificationsListLeadingWarning extends StatelessWidget {
  const NotificationsListLeadingWarning({super.key});

  static const _containerSize = 40.0;
  static const _containerOpacity = 0.1;
  static const _iconSize = 16.0;
  static const _color = Color(0xFFF1013F);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _containerSize,
      width: _containerSize,
      decoration: BoxDecoration(
        color: _color.withOpacity(_containerOpacity),
        shape: BoxShape.circle,
      ),
      child: PicnicImage(
        source: PicnicImageSource.asset(
          ImageUrl(
            Assets.images.info.path,
          ),
          color: _color,
          width: _iconSize,
          height: _iconSize,
        ),
      ),
    );
  }
}
