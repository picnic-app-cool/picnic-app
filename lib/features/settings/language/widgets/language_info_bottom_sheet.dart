import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class LanguageInfoBottomSheet extends StatelessWidget {
  const LanguageInfoBottomSheet({
    super.key,
    required this.onTap,
  });

  static const paddingSize = 20.0;
  static const borderButtonWidth = 2.0;
  static const borderRadius = 50.0;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Padding(
      padding: const EdgeInsets.all(paddingSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            appLocalizations.languageSelectionTitle,
            style: theme.styles.subtitle40,
            textAlign: TextAlign.left,
          ),
          const Gap(12),
          Text(
            appLocalizations.languageSelectionInfo,
            style: theme.styles.body20,
            textAlign: TextAlign.left,
          ),
          const Gap(10),
          Center(
            child: PicnicTextButton(
              label: appLocalizations.closeAction,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
