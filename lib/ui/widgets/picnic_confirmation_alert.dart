// ignore_for_file: comment_references

import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog_title.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

///Do no use [PicnicConfirmationAlert] directly on page,
///instead use [ConfirmationAlertRoute.showConfirmationAlert]
class PicnicConfirmationAlert extends StatelessWidget {
  const PicnicConfirmationAlert({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.iconEmoji,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String description;
  final String buttonLabel;
  final String iconEmoji;
  final VoidCallback? onTap;

  static const _alertPadding = EdgeInsets.only(
    left: 16.0,
    right: 16.0,
    top: 24.0,
    bottom: 18.0,
  );
  static const _avatarSize = 88.0;
  static const _dialogRadius = 16.0;
  static const _backgroundOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    return Material(
      color: blackAndWhite.shade700.withOpacity(_backgroundOpacity),
      child: InkWell(
        onTap: () => _close(context),
        child: Center(
          child: Padding(
            padding: _alertPadding,
            child: PicnicDialog(
              image: PicnicAvatar(
                size: _avatarSize,
                backgroundColor: blackAndWhite.shade900.withOpacity(Constants.onboardingImageBgOpacity),
                imageSource: PicnicImageSource.emoji(
                  iconEmoji,
                  style: const TextStyle(
                    fontSize: Constants.onboardingEmojiSize,
                  ),
                ),
              ),
              descriptionTextStyle: theme.styles.caption10.copyWith(color: blackAndWhite.shade600),
              titleTextStyle: theme.styles.subtitle30,
              titleSize: PicnicDialogTitleSize.custom,
              title: title,
              radius: _dialogRadius,
              description: description,
              content: SizedBox(
                width: double.infinity,
                child: PicnicButton(
                  onTap: () => _onTap(context),
                  title: buttonLabel,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    _close(context);
    onTap?.call();
  }

  void _close(BuildContext context) => Navigator.pop(context);
}
