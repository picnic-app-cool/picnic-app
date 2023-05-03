import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class JoinButton extends StatelessWidget {
  const JoinButton({
    Key? key,
    required this.isJoined,
    required this.onTapJoin,
  }) : super(key: key);

  final bool isJoined;
  final VoidCallback onTapJoin;

  @override
  Widget build(BuildContext context) {
    return PicnicButton(
      title: isJoined ? appLocalizations.joinedButtonActionTitle : appLocalizations.joinAction,
      onTap: isJoined ? null : onTapJoin,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }
}
