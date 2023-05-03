import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SoundAttachmentItem extends StatelessWidget {
  const SoundAttachmentItem({
    Key? key,
    required this.sound,
    required this.onTapDeleteSoundAttachment,
  }) : super(key: key);

  final Sound sound;
  final VoidCallback onTapDeleteSoundAttachment;

  static const _padding = EdgeInsets.fromLTRB(
    Constants.lowPadding,
    8.0,
    Constants.lowPadding,
    8.0,
  );
  static const _imageRadius = 16.0;
  static const _elementsPadding = 4.0;
  static const _borderRadius = BorderRadius.all(
    Radius.circular(
      Constants.borderRadiusL,
    ),
  );
  static const _blurRadius = 30.0;
  static const _boxShadowOpacity = 0.07;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhiteColor = colors.blackAndWhite;
    final nameStyle = theme.styles.body20.copyWith(color: colors.blackAndWhite.shade800);
    final captionStyle = theme.styles.caption10.copyWith(color: colors.blackAndWhite.shade500);

    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: _blurRadius,
            color: blackAndWhiteColor.shade900.withOpacity(_boxShadowOpacity),
            offset: const Offset(0, 2),
          ),
        ],
        color: blackAndWhiteColor.shade100,
        borderRadius: _borderRadius,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: _imageRadius, // Image radius
            backgroundImage: NetworkImage(sound.icon.url),
          ),
          const Gap(_elementsPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sound.title,
                  style: nameStyle,
                ),
                Text(
                  appLocalizations.soundAttachmentItemCaption,
                  style: captionStyle,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTapDeleteSoundAttachment,
            child: Image.asset(Assets.images.bin.path),
          ),
        ],
      ),
    );
  }
}
