import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_container_button.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PicnicShareBar extends StatelessWidget {
  const PicnicShareBar({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PicnicButton(
            title: appLocalizations.shareAction,
            onTap: onTap,
          ),
        ),
        _SocialButton(imagePath: Assets.images.socialTiktok.path, onTap: onTap),
        _SocialButton(imagePath: Assets.images.socialInstagram.path, onTap: onTap),
        _SocialButton(imagePath: Assets.images.socialSnapchat.path, onTap: onTap),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    Key? key,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  final String imagePath;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: PicnicContainerButton(
        onTap: onTap,
        padding: 0.0,
        child: PicnicImage(
          source: PicnicImageSource.asset(ImageUrl(imagePath)),
        ),
      ),
    );
  }
}
