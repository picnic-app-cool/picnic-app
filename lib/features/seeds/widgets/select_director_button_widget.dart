import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class SelectDirectorButtonWidget extends StatelessWidget {
  const SelectDirectorButtonWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final votedColor = PicnicTheme.of(context).colors.blue.shade500;
    final buttonText = appLocalizations.circleElectionVote;

    return Padding(
      padding: const EdgeInsets.only(
        right: 24,
        left: 24,
        top: 12,
        bottom: 12,
      ),
      child: PicnicButton(
        title: buttonText,
        borderColor: votedColor,
        size: PicnicButtonSize.large,
        onTap: onTap,
      ),
    );
  }
}
