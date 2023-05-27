import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class NoRules extends StatelessWidget {
  const NoRules({
    Key? key,
    required this.onTapEdit,
    required this.isMod,
  }) : super(key: key);
  final VoidCallback onTapEdit;
  final bool isMod;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;

    return Stack(
      alignment: Alignment.topRight,
      children: [
        PicnicDialog(
          image: PicnicAvatar(
            backgroundColor: theme.colors.blackAndWhite.shade900.withOpacity(Constants.onboardingImageBgOpacity),
            imageSource: PicnicImageSource.emoji(
              Constants.faceTongueEmoji,
              style: const TextStyle(
                fontSize: 55.0,
              ),
            ),
          ),
          title: appLocalizations.circleDetailsNoRulesTitle,
          description: appLocalizations.circleDetailsNoRulesDescription,
          showShadow: false,
          reverse: false,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appLocalizations.rulesTabTitle, style: styles.subtitle40),
                  if (isMod)
                    PicnicTextButton(
                      label: appLocalizations.editAction,
                      onTap: onTapEdit,
                      labelStyle: theme.styles.subtitle30.copyWith(color: theme.colors.blue),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
