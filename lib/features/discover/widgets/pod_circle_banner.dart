import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PodCircleBanner extends StatelessWidget {
  const PodCircleBanner({
    Key? key,
    required this.title,
    required this.imagePath,
    this.onTap,
    this.width = _width,
  }) : super(key: key);

  final String title;
  final String imagePath;
  final double width;
  final VoidCallback? onTap;

  static const _opacity = 0.8;
  static const _width = 180.0;
  static const _height = 80.0;
  static const _borderRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    final themeData = PicnicTheme.of(context);
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: width,
            height: _height,
            child: Opacity(
              opacity: _opacity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_borderRadius),
                child: PicnicImage(
                  placeholder: () => Image.asset(Assets.images.podPlaceholderImg.path),
                  source: PicnicImageSource.asset(
                    ImageUrl(imagePath),
                    width: width,
                    fit: BoxFit.cover,
                    height: _height,
                  ),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: themeData.styles.title40.copyWith(color: themeData.colors.blackAndWhite.shade100),
          ),
        ],
      ),
    );
  }
}
