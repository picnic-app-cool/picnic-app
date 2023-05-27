import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class PicnicVerticalActionBottomSheet extends StatelessWidget {
  const PicnicVerticalActionBottomSheet({
    Key? key,
    required this.actions,
    required this.onTapClose,
    this.title,
    this.description,
  }) : super(key: key);

  final List<ActionBottom> actions;
  final VoidCallback onTapClose;
  final String? title;
  final String? description;

  static const _contentPadding = EdgeInsets.symmetric(horizontal: 20.0);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          const Gap(20),
          Padding(
            padding: _contentPadding,
            child: Text(
              title ?? '',
              style: theme.styles.subtitle40,
            ),
          ),
        ],
        if (description != null) ...[
          const Gap(8),
          Padding(
            padding: _contentPadding,
            child: Text(
              description ?? '',
              style: theme.styles.caption10.copyWith(
                color: colors.blackAndWhite.shade600,
              ),
            ),
          ),
        ],
        const Gap(22),
        ...actions.map((e) {
          final textColor = e.isPrimary ? colors.blackAndWhite.shade100 : colors.darkBlue.shade600;
          return Container(
            margin: _contentPadding,
            width: double.infinity,
            child: PicnicButton(
              style: e.isPrimary ? PicnicButtonStyle.filled : PicnicButtonStyle.outlined,
              titleStyle: theme.styles.body20.copyWith(color: textColor),
              color: e.isPrimary ? colors.pink.shade500 : null,
              icon: e.icon,
              onTap: e.action,
              titleColor: textColor,
              title: e.label,
            ),
          );
        }).toList(),
        Center(
          child: Container(
            width: double.infinity,
            margin: _contentPadding,
            child: PicnicTextButton(
              label: appLocalizations.closeAction,
              onTap: onTapClose,
            ),
          ),
        ),
        const Gap(16),
      ],
    );
  }
}
