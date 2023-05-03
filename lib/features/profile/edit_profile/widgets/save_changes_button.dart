import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class SaveChangesButton extends StatelessWidget {
  const SaveChangesButton({Key? key, this.onTapSave}) : super(key: key);

  final VoidCallback? onTapSave;
  static const paddingSize = 20.0;
  static const borderButtonWidth = 2.0;
  static const borderRadius = 50.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    return PicnicButton(
      borderRadius: const PicnicButtonRadius.round(),
      minWidth: double.infinity,
      title: appLocalizations.unSavedInfoFirstAction,
      color: colors.green,
      borderColor: colors.green,
      titleColor: colors.blackAndWhite.shade100,
      style: PicnicButtonStyle.outlined,
      borderWidth: borderButtonWidth,
      onTap: onTapSave,
    );
  }
}
