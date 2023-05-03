import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/settings/single_chat_settings_actions.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_action_button.dart';

class SingleChatSettingsButtons extends StatelessWidget {
  const SingleChatSettingsButtons({
    Key? key,
    required this.onButtonTap,
    required this.followed,
    required this.followMe,
    required this.muted,
    required this.followResult,
    required this.muteResult,
  }) : super(key: key);

  final bool followed;
  final bool muted;
  final bool followMe;
  final FutureResult<void> followResult;
  final FutureResult<void> muteResult;
  final ValueChanged<SingleChatSettingsActions> onButtonTap;

  static const _iconWidth = 20.0;

  @override
  Widget build(BuildContext context) {
    final isGlitterBombEnabled = followMe && followed;
    final values = SingleChatSettingsActions.values.toList();
    if (isGlitterBombEnabled) {
      values.removeWhere((it) => it == SingleChatSettingsActions.follow);
    } else {
      values.removeWhere((it) => it == SingleChatSettingsActions.glitterbomb);
    }

    return Row(
      children: values.map(
        (element) {
          final String label;
          final String icon;
          final VoidCallback? action;
          switch (element) {
            case SingleChatSettingsActions.report:
              label = appLocalizations.reportAction;
              icon = Assets.images.infoOutlined.path;
              action = () => onButtonTap(element);
              break;
            case SingleChatSettingsActions.follow:
              label = followed ? appLocalizations.followingAction : appLocalizations.followAction;
              icon = followed ? Assets.images.unfollow.path : Assets.images.follow.path;
              action = followResult.isPending() ? null : () => onButtonTap(element);
              break;
            case SingleChatSettingsActions.mute:
              label = muted ? appLocalizations.unmuteAction : appLocalizations.muteAction;
              icon = muted ? Assets.images.unmute.path : Assets.images.mute.path;
              action = muteResult.isPending() ? null : () => onButtonTap(element);
              break;
            case SingleChatSettingsActions.glitterbomb:
              label = appLocalizations.glitterbombButtonActionTitle;
              icon = Assets.images.glitterOutline.path;
              action = () => onButtonTap(element);
              break;
          }
          return Expanded(
            child: PicnicActionButton(
              icon: Image.asset(
                icon,
                width: _iconWidth,
              ),
              label: label,
              onTap: action,
            ),
          );
        },
      ).toList(growable: false),
    );
  }
}
