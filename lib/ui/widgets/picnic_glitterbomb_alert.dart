import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog_title.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PicnicGlitterBombAlert extends StatelessWidget {
  const PicnicGlitterBombAlert({
    super.key,
    this.avatarImage = const ImageUrl.empty(),
    this.senderUsername = '',
    this.onTapGlitterbombBack,
  });

  final ImageUrl avatarImage;
  final String senderUsername;
  final VoidCallback? onTapGlitterbombBack;

  static const double _avatarImageBgOpacity = 0.4;
  static const double _dialogRadius = 24.0;
  static const double _dialogContentPadding = 12.0;
  static const double _dialogTitleSpacing = 8.0;
  static const double _avatarImageSpacing = 12.0;
  static const _dialogPadding = EdgeInsets.only(
    top: 26,
    bottom: 26,
    left: 32,
    right: 32,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return PicnicDialog(
      radius: _dialogRadius,
      imageSpacing: _avatarImageSpacing,
      titleSpacing: _dialogTitleSpacing,
      dialogPadding: _dialogPadding,
      contentPadding: _dialogContentPadding,
      image: PicnicAvatar(
        backgroundColor: theme.colors.blue.shade200.withOpacity(
          _avatarImageBgOpacity,
        ),
        imageSource: PicnicImageSource.emoji(
          avatarImage.url,
          style: const TextStyle(fontSize: 35),
        ),
      ),
      title: appLocalizations.glitterboombAlertTitle,
      titleSize: PicnicDialogTitleSize.custom,
      titleTextStyle: theme.styles.subtitle30,
      description: appLocalizations.glitterboombAlertDescription(
        senderUsername.formattedUsername,
      ),
      descriptionTextStyle: theme.styles.caption10.copyWith(
        color: theme.colors.blackAndWhite.shade600,
      ),
      content: PicnicButton(
        color: theme.colors.pink,
        onTap: onTapGlitterbombBack,
        title: appLocalizations.glitterboombAlertButtonAction,
        size: PicnicButtonSize.large,
        icon: Assets.images.glitter.path,
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}
