import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class BlockUserButton extends StatelessWidget {
  const BlockUserButton({required this.onTapToggleBlock, this.isBlocked = false});

  final VoidCallback onTapToggleBlock;
  final bool isBlocked;

  static const _unBlockedBorderWidth = 2.0;
  static const _blockedBorderWidth = 3.0;
  static const _blockedPadding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0);
  static const _notBlockedPadding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final red = colors.pink.shade500;
    return PicnicButton(
      padding: isBlocked ? _blockedPadding : _notBlockedPadding,
      title: isBlocked ? appLocalizations.blockAction : appLocalizations.unblockedAction,
      style: PicnicButtonStyle.outlined,
      color: isBlocked ? red : Colors.transparent,
      titleColor: isBlocked ? colors.blackAndWhite.shade100 : red,
      onTap: onTapToggleBlock,
      borderWidth: isBlocked ? _blockedBorderWidth : _unBlockedBorderWidth,
      borderColor: red,
    );
  }
}
