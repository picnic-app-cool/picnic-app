import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class UnbanButton extends StatelessWidget {
  const UnbanButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  static const _borderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final redColor = theme.colors.red;
    return PicnicButton(
      title: appLocalizations.unbanAction,
      borderColor: redColor,
      borderWidth: _borderWidth,
      titleColor: redColor,
      onTap: onTap,
      style: PicnicButtonStyle.outlined,
    );
  }
}
