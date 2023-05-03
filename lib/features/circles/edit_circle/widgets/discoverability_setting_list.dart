import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';
import 'package:picnic_app/features/circles/edit_circle/widgets/discoverability_setting_section.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DiscoverabilitySettingList extends StatelessWidget {
  const DiscoverabilitySettingList({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  final CircleVisibility groupValue;
  final ValueChanged<CircleVisibility> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.circlePrivacy,
          style: styles.title20,
        ),
        const Gap(16),
        DiscoverabilitySettingSection(
          label: appLocalizations.circleOpenHeadline,
          onChanged: onChanged,
          description: appLocalizations.circleOpenDescription,
          value: CircleVisibility.opened,
          groupValue: groupValue,
        ),
        const Gap(8),
        DiscoverabilitySettingSection(
          label: appLocalizations.circleClosedHeadline,
          onChanged: onChanged,
          description: appLocalizations.circleClosedDescription,
          value: CircleVisibility.closed,
          groupValue: groupValue,
        ),
        const Gap(8),
        DiscoverabilitySettingSection(
          label: appLocalizations.circlePrivateHeadline,
          onChanged: onChanged,
          description: appLocalizations.circlePrivateDescription,
          value: CircleVisibility.private,
          groupValue: groupValue,
        ),
      ],
    );
  }
}
