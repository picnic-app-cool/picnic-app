import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/ui/widgets/picnic_switch.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleRolePermissionSection extends StatelessWidget {
  const CircleRolePermissionSection({
    required this.initialSwitchValue,
    required this.onSwitchChanged,
    required this.text,
    required this.description,
    Key? key,
  }) : super(key: key);

  final bool initialSwitchValue;
  final ValueChanged<bool> onSwitchChanged;
  final String text;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              text,
              style: theme.styles.title20,
            ),
            const Spacer(),
            PicnicSwitch(
              value: initialSwitchValue,
              onChanged: onSwitchChanged,
              size: PicnicSwitchSize.regular,
              color: theme.colors.green,
            ),
          ],
        ),
        Text(
          description,
          style: theme.styles.body20.copyWith(
            color: theme.colors.blackAndWhite.shade400,
          ),
        ),
        const Gap(4),
      ],
    );
  }
}
