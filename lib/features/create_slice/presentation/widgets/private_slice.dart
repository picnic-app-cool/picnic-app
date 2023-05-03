import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PrivateSlice extends StatelessWidget {
  static const _avatarSize = 88.0;
  static const _fontSize = 42.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Gap(54),
          PicnicAvatar(
            size: _avatarSize,
            backgroundColor: colors.blackAndWhite.shade200,
            imageSource: PicnicImageSource.emoji(
              Constants.lockEmoji,
              style: styles.title40.copyWith(fontSize: _fontSize),
            ),
          ),
          const Gap(16),
          Text(
            appLocalizations.privateSlice,
            style: styles.title30,
          ),
          Text(
            appLocalizations.privateSliceLabel,
            textAlign: TextAlign.center,
            style: styles.body30.copyWith(color: colors.blackAndWhite.shade600),
          ),
        ],
      ),
    );
  }
}
