import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class MultiSelectPostsConfirmation extends StatelessWidget {
  const MultiSelectPostsConfirmation({
    required this.title,
    required this.actionLabel,
    required this.onTapConfirm,
    required this.onTapClose,
    super.key,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onTapConfirm;
  final VoidCallback onTapClose;

  static const _contentPadding = EdgeInsets.symmetric(horizontal: 20.0);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final pink = theme.colors.pink.shade500;
    const elevation = 8.0;
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    );

    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      color: blackAndWhite.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(20),
          Padding(
            padding: _contentPadding,
            child: Text(
              title,
              style: theme.styles.subtitle40,
            ),
          ),
          const Gap(22),
          Container(
            margin: _contentPadding,
            width: double.infinity,
            child: PicnicButton(
              titleStyle: theme.styles.body20.copyWith(color: blackAndWhite.shade100),
              color: pink,
              onTap: onTapConfirm,
              titleColor: blackAndWhite.shade100,
              title: actionLabel,
            ),
          ),
          Center(
            child: PicnicTextButton(
              label: appLocalizations.closeAction,
              onTap: onTapClose,
            ),
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
