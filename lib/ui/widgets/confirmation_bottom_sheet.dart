import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  const ConfirmationBottomSheet({
    super.key,
    this.topImagePath,
    required this.title,
    required this.message,
    required this.primaryAction,
    this.secondaryAction,
    this.titleAction,
    this.contentWidget,
    this.color,
  });

  static const paddingSize = 20.0;
  static const borderButtonWidth = 2.0;
  static const borderRadius = 50.0;

  final String? topImagePath;
  final String title;
  final String message;
  final ConfirmationAction primaryAction;
  final ConfirmationAction? secondaryAction;
  final ConfirmationAction? titleAction;
  final Widget? contentWidget;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhiteShade600 = colors.blackAndWhite.shade600;
    final showExtraContent = contentWidget != null;

    return Padding(
      padding: const EdgeInsets.all(paddingSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (topImagePath != null) ...[
            Center(
              child: Image.asset(
                topImagePath!,
              ),
            ),
            const Gap(20),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.styles.title30,
                textAlign: TextAlign.left,
              ),
              if (titleAction != null) ...[
                PicnicTextButton(
                  label: titleAction!.title,
                  labelStyle: theme.styles.body30.copyWith(
                    color: blackAndWhiteShade600,
                  ),
                  onTap: titleAction!.action,
                ),
              ],
            ],
          ),
          const Gap(8),
          Text(
            message,
            style: theme.styles.caption10.copyWith(color: blackAndWhiteShade600),
            textAlign: TextAlign.left,
          ),
          const Gap(4),
          if (showExtraContent) contentWidget!,
          const Gap(10),
          PicnicButton(
            borderRadius:
                primaryAction.roundedButton ? const PicnicButtonRadius.round() : const PicnicButtonRadius.semiRound(),
            minWidth: double.infinity,
            title: primaryAction.title,
            color: primaryAction.isPositive ? colors.green : colors.pink,
            borderColor: primaryAction.isPositive ? colors.green : colors.pink,
            titleColor: Colors.white,
            style: PicnicButtonStyle.outlined,
            borderWidth: borderButtonWidth,
            onTap: primaryAction.action,
          ),
          if (secondaryAction != null) ...[
            const Gap(4),
            Center(
              child: PicnicTextButton(
                label: secondaryAction!.title,
                onTap: secondaryAction!.action,
              ),
            ),
          ] else
            const Gap(40),
        ],
      ),
    );
  }
}
