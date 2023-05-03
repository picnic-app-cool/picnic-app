import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FeatureFlagItem extends StatelessWidget {
  const FeatureFlagItem({
    Key? key,
    required this.featureFlagType,
    required this.isEnabled,
    required this.onChangeStateTap,
  }) : super(key: key);

  final FeatureFlagType featureFlagType;
  final bool isEnabled;
  final Function(FeatureFlagType) onChangeStateTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    featureFlagType.name,
                    style: PicnicTheme.of(context).styles.body20,
                  ),
                  const Gap(4),
                  Text(featureFlagType.description),
                ],
              ),
            ),
            CupertinoSwitch(
              onChanged: (_) => onChangeStateTap(featureFlagType),
              value: isEnabled,
            ),
          ],
        ),
      );
}
