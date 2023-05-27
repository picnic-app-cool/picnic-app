import 'package:flutter/material.dart';
import 'package:picnic_app/features/profile/domain/model/public_profile_action.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PublicProfileButtons extends StatelessWidget {
  const PublicProfileButtons({
    Key? key,
    required this.action,
    required this.onTapDM,
    required this.onTapAction,
    required this.isBlocked,
  }) : super(key: key);

  final PublicProfileAction action;
  final VoidCallback? onTapDM;
  final VoidCallback onTapAction;
  final bool isBlocked;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final darkBlue = theme.colors.darkBlue;
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 4,
            ),
            child: PicnicButton(
              titleColor: darkBlue.shade800,
              color: darkBlue.shade300,
              title: appLocalizations.dmTitle,
              onTap: isBlocked ? null : onTapDM,
              minWidth: double.infinity,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 24,
              left: 4,
            ),
            child: _ActionButton(
              action: action,
              onTapAction: onTapAction,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
    required this.action,
    required this.onTapAction,
  }) : super(key: key);

  final PublicProfileAction action;
  final VoidCallback onTapAction;

  static const double _borderWidth = 2;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return PicnicButton(
      title: _getActionTitle(),
      titleColor: _getTitleColor(colors),
      color: _getButtonColor(colors),
      borderWidth: _getBorderWidth(),
      borderColor: _getBorderColor(colors),
      style: _getButtonStyle(),
      padding: _getButtonPadding(),
      minWidth: double.infinity,
      onTap: onTapAction,
    );
  }

  String _getActionTitle() {
    switch (action) {
      case PublicProfileAction.follow:
        return appLocalizations.followButtonActionTitle;
      case PublicProfileAction.glitterbomb:
        return appLocalizations.glitterbombButtonActionTitle;
      case PublicProfileAction.following:
        return appLocalizations.followingButtonActionTitle;
      case PublicProfileAction.blocked:
        return appLocalizations.blockedButtonActionTitle;
    }
  }

  Color _getTitleColor(PicnicColors colors) {
    switch (action) {
      case PublicProfileAction.follow:
      case PublicProfileAction.glitterbomb:
        return colors.blackAndWhite.shade100;
      case PublicProfileAction.following:
      case PublicProfileAction.blocked:
        return colors.blue.shade500;
    }
  }

  Color _getButtonColor(PicnicColors colors) {
    switch (action) {
      case PublicProfileAction.follow:
      case PublicProfileAction.glitterbomb:
        return colors.blue.shade500;
      case PublicProfileAction.following:
      case PublicProfileAction.blocked:
        return colors.blackAndWhite.shade100;
    }
  }

  PicnicButtonStyle _getButtonStyle() {
    switch (action) {
      case PublicProfileAction.follow:
      case PublicProfileAction.glitterbomb:
        return PicnicButtonStyle.filled;
      case PublicProfileAction.following:
      case PublicProfileAction.blocked:
        return PicnicButtonStyle.outlined;
    }
  }

  double _getBorderWidth() {
    switch (action) {
      case PublicProfileAction.follow:
      case PublicProfileAction.glitterbomb:
        return 0;
      case PublicProfileAction.following:
      case PublicProfileAction.blocked:
        return _borderWidth;
    }
  }

  Color _getBorderColor(PicnicColors colors) {
    switch (action) {
      case PublicProfileAction.follow:
      case PublicProfileAction.glitterbomb:
        return Colors.transparent;
      case PublicProfileAction.following:
      case PublicProfileAction.blocked:
        return colors.blue.shade500;
    }
  }

  EdgeInsets _getButtonPadding() {
    switch (action) {
      case PublicProfileAction.follow:
      case PublicProfileAction.glitterbomb:
        return const EdgeInsets.symmetric(vertical: 16);
      case PublicProfileAction.following:
      case PublicProfileAction.blocked:
        return const EdgeInsets.symmetric(vertical: 16);
    }
  }
}
