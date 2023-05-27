import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DiscoverSearchInitialPlaceholder extends StatelessWidget {
  static const double _imageSize = 88;
  static const double _imageBackgroundOpacity = 0.05;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    return Column(
      children: [
        const Spacer(),
        PicnicAvatar(
          backgroundColor: colors.blackAndWhite[900]?.withOpacity(_imageBackgroundOpacity),
          size: _imageSize,
          boxFit: PicnicAvatarChildBoxFit.cover,
          imageSource: PicnicImageSource.emoji(
            Constants.eyesEmoji,
            style: const TextStyle(
              fontSize: 42,
            ),
          ),
        ),
        Text(
          appLocalizations.discoveryInitialHintTitle,
          style: styles.subtitle40,
        ),
        Text(
          appLocalizations.discoveryInitialHintSubtitle,
          style: styles.body30.copyWith(
            color: colors.blackAndWhite[600],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
