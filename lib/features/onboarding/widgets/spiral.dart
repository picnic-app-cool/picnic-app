import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

//ignore_for_file: no-magic-number
class Spiral extends StatelessWidget {
  const Spiral({Key? key}) : super(key: key);

  static const double _heightFactor = 0.4;
  static const double _horizontalMargin = 12.0;

  static const double _circle1SizeFactor = 1;
  static const double _circle2SizeFactor = 0.71;
  static const double _circle3SizeFactor = 0.49;
  static const double _circle4SizeFactor = 0.328;

  static const double _emoji1PositionFactor = 0.275;

  static const double _emoji2PositionFactor = 0.1;

  static const double _emoji3LeftPositionFactor = 0.231;

  static const double _emoji4BottomPositionFactor = 0.547;
  static const double _emoji4RightPositionFactor = 0.136;

  static const double _image1BottomPositionFactor = 0.493;
  static const double _image1LeftPositionFactor = 0.136;
  static const double _image1SizeFactor = 0.243;

  static const double _image2BottomPositionFactor = 0.593;
  static const double _image2RightPositionFactor = 0.136;
  static const double _image2SizeFactor = 0.263;

  static const double _image3BottomPositionFactor = 0.553;
  static const double _image3RightPositionFactor = 0.301;
  static const double _image3SizeFactor = 0.183;

  static const double _image4TopPositionFactor = 0.553;
  static const double _image4LeftPositionFactor = 0.261;
  static const double _image4SizeFactor = 0.243;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final availableSpaceOnWidth = screenSize.width - (_horizontalMargin * 2);

    final percentageOfScreenHeight = screenSize.height * _heightFactor;
    final circleSize = min(availableSpaceOnWidth, percentageOfScreenHeight);

    const grey = Color.fromRGBO(
      217,
      224,
      233,
      1,
    );
    final circle = BoxDecoration(
      border: Border.all(
        color: grey,
        width: 2,
      ),
      shape: BoxShape.circle,
      color: Colors.white,
    );
    final styles = PicnicTheme.of(context).styles;
    final display10 = styles.display10;
    return Center(
      child: SizedBox(
        height: circleSize,
        width: circleSize,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: circleSize * _circle1SizeFactor,
              height: circleSize * _circle1SizeFactor,
              decoration: circle,
            ),
            Container(
              width: circleSize * _circle2SizeFactor,
              height: circleSize * _circle2SizeFactor,
              decoration: circle,
            ),
            Container(
              width: circleSize * _circle3SizeFactor,
              height: circleSize * _circle3SizeFactor,
              decoration: circle,
            ),
            Container(
              width: circleSize * _circle4SizeFactor,
              height: circleSize * _circle4SizeFactor,
              decoration: circle,
            ),
            Positioned(
              right: circleSize * _emoji1PositionFactor,
              top: -1,
              child: Text(
                "😊",
                style: display10,
              ),
            ),
            Positioned(
              top: circleSize * _emoji2PositionFactor,
              left: circleSize * _emoji2PositionFactor,
              child: Text(
                "🤩",
                style: display10,
              ),
            ),
            Positioned(
              bottom: 0,
              left: circleSize * _emoji3LeftPositionFactor,
              child: Text(
                "🥰",
                style: display10,
              ),
            ),
            Positioned(
              bottom: circleSize * _emoji4BottomPositionFactor,
              right: circleSize * _emoji4RightPositionFactor,
              child: Text(
                "😉",
                style: display10,
              ),
            ),
            Positioned(
              bottom: circleSize * _image1BottomPositionFactor,
              left: circleSize * _image1LeftPositionFactor,
              child: PicnicAvatar(
                size: circleSize * _image1SizeFactor,
                boxFit: PicnicAvatarChildBoxFit.cover,
                imageSource: PicnicImageSource.asset(
                  ImageUrl(Assets.images.circleExample1.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: circleSize * _image2BottomPositionFactor,
              right: circleSize * _image2RightPositionFactor,
              child: PicnicAvatar(
                size: circleSize * _image2SizeFactor,
                boxFit: PicnicAvatarChildBoxFit.cover,
                imageSource: PicnicImageSource.asset(
                  ImageUrl(Assets.images.circleExample2.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: circleSize * _image3BottomPositionFactor,
              right: circleSize * _image3RightPositionFactor,
              child: PicnicAvatar(
                size: circleSize * _image3SizeFactor,
                boxFit: PicnicAvatarChildBoxFit.cover,
                imageSource: PicnicImageSource.asset(
                  ImageUrl(Assets.images.circleExample3.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: circleSize * _image4TopPositionFactor,
              left: circleSize * _image4LeftPositionFactor,
              child: PicnicAvatar(
                size: circleSize * _image4SizeFactor,
                boxFit: PicnicAvatarChildBoxFit.cover,
                imageSource: PicnicImageSource.asset(
                  ImageUrl(Assets.images.circleExample4.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
