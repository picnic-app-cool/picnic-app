import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

//ignore_for_file: no-magic-number
class Spiral extends StatelessWidget {
  const Spiral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        height: 365,
        width: 365,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 360,
              height: 360,
              decoration: circle,
            ),
            Container(
              width: 260,
              height: 260,
              decoration: circle,
            ),
            Container(
              width: 180,
              height: 180,
              decoration: circle,
            ),
            Container(
              width: 120,
              height: 120,
              decoration: circle,
            ),
            Positioned(
              right: 150,
              top: -1,
              child: Text(
                "😊",
                style: display10,
              ),
            ),
            Positioned(
              top: 50,
              left: 50,
              child: Text(
                "🤩",
                style: display10,
              ),
            ),
            Positioned(
              bottom: 50,
              left: 40,
              child: Text(
                "🥰",
                style: display10,
              ),
            ),
            Positioned(
              bottom: 200,
              right: 50,
              child: Text(
                "😉",
                style: display10,
              ),
            ),
            Positioned(
              bottom: 180,
              left: 50,
              child: PicnicAvatar(
                size: 96,
                boxFit: PicnicAvatarChildBoxFit.cover,
                imageSource: PicnicImageSource.asset(
                  ImageUrl(Assets.images.circleExample1.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 200,
              right: 50,
              child: PicnicAvatar(
                size: 96,
                boxFit: PicnicAvatarChildBoxFit.cover,
                imageSource: PicnicImageSource.asset(
                  ImageUrl(Assets.images.circleExample2.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 200,
              right: 110,
              child: PicnicAvatar(
                size: 68,
                boxFit: PicnicAvatarChildBoxFit.cover,
                imageSource: PicnicImageSource.asset(
                  ImageUrl(Assets.images.circleExample3.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: 110,
              child: PicnicAvatar(
                size: 68,
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
