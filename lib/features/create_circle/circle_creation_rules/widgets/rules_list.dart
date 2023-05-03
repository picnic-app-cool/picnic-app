import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/widgets/circle_rule.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class RulesList extends StatelessWidget {
  const RulesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        CircleRule(
          title: appLocalizations.circlesRulesTitleOne,
          description: appLocalizations.circlesRulesDescriptionOne,
        ),
        const Gap(20),
        CircleRule(
          title: appLocalizations.circlesRulesTitleTwo,
          description: appLocalizations.circlesRulesDescriptionTwo,
        ),
        const Gap(20),
        CircleRule(
          title: appLocalizations.circlesRulesTitleThree,
          description: appLocalizations.circlesRulesDescriptionThree,
        ),
      ],
    );
  }
}
