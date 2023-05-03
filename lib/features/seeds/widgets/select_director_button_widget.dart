import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class SelectDirectorButtonWidget extends StatelessWidget {
  const SelectDirectorButtonWidget({
    Key? key,
    required this.isVoted,
    required this.onTap,
  }) : super(key: key);

  final bool isVoted;
  final VoidCallback? onTap;

  static const _borderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final votedColor = PicnicTheme.of(context).colors.green.shade500;
    final buttonText =
        isVoted ? appLocalizations.circleElectionChangeVoteForDirector : appLocalizations.circleElectionVoteForDirector;

    return Padding(
      padding: const EdgeInsets.only(
        right: 24,
        left: 24,
        top: 12,
        bottom: 24,
      ),
      child: PicnicButton(
        title: buttonText,
        style: isVoted ? PicnicButtonStyle.outlined : PicnicButtonStyle.filled,
        borderColor: votedColor,
        size: PicnicButtonSize.large,
        titleColor: isVoted ? votedColor : null,
        borderWidth: isVoted ? _borderWidth : 0,
        onTap: onTap,
      ),
    );
  }
}
