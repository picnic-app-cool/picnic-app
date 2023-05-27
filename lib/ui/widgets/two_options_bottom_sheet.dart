import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class TwoOptionsBottomSheet extends StatelessWidget {
  const TwoOptionsBottomSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.footer,
    required this.onTapFooter,
    this.primaryButton,
    this.secondaryButton,
  });

  static const paddingSize = 20.0;
  static const borderButtonWidth = 2.0;
  static const borderRadius = 50.0;

  final String title;
  final String subtitle;
  final String footer;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final VoidCallback onTapFooter;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return Padding(
      padding: const EdgeInsets.all(paddingSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.styles.subtitle40,
            textAlign: TextAlign.left,
          ),
          const Gap(8),
          Text(
            subtitle,
            style: theme.styles.caption10.copyWith(color: colors.blackAndWhite.shade600),
            textAlign: TextAlign.left,
          ),
          const Gap(20),
          if (primaryButton != null) primaryButton!,
          const Gap(16),
          if (secondaryButton != null) secondaryButton!,
          const Gap(20),
          Center(
            child: PicnicTextButton(
              label: footer,
              onTap: onTapFooter,
            ),
          ),
        ],
      ),
    );
  }
}
