import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class NoRoyals extends StatelessWidget {
  const NoRoyals({Key? key}) : super(key: key);

  static const _avatarSize = 88.0;
  static const _avatarOpacity = 0.05;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return PicnicDialog(
      image: PicnicAvatar(
        imageSource: PicnicImageSource.emoji(
          Constants.noCrownEmoji,
          style: const TextStyle(fontSize: 55.0),
        ),
        size: _avatarSize,
        backgroundColor: colors.blackAndWhite.shade900.withOpacity(_avatarOpacity),
      ),
      title: appLocalizations.circleDetailsNoRoyaltyTitle,
      description: appLocalizations.circleDetailsNoRoyaltyDescription,
      showShadow: false,
    );
  }
}
