import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class NewCircleButton extends StatelessWidget {
  const NewCircleButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return PicnicButton(
      padding: EdgeInsets.zero,
      title: appLocalizations.newCircleAction,
      color: Colors.transparent,
      titleStyle: theme.styles.subtitle20.copyWith(
        color: theme.colors.blue.shade600,
      ),
      onTap: onTap,
    );
  }
}
