import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class UserBannedIndicator extends StatelessWidget {
  const UserBannedIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final pink = PicnicTheme.of(context).colors.pink;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.defaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.info,
            color: pink,
          ),
          const Gap(8),
          Text(
            appLocalizations.userBannedMessage,
            style: TextStyle(color: pink),
          ),
        ],
      ),
    );
  }
}
