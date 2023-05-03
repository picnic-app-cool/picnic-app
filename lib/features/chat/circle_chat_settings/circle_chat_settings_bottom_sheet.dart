import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_presentation_model.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_presenter.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/ui/widgets/status_bars/light_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_action_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class CircleChatSettingsBottomSheet extends StatefulWidget with HasPresenter<CircleChatSettingsPresenter> {
  const CircleChatSettingsBottomSheet({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CircleChatSettingsPresenter presenter;

  @override
  State<CircleChatSettingsBottomSheet> createState() => _CircleChatSettingsPageState();
}

class _CircleChatSettingsPageState extends State<CircleChatSettingsBottomSheet>
    with PresenterStateMixin<CircleChatSettingsViewModel, CircleChatSettingsPresenter, CircleChatSettingsBottomSheet> {
  static const _horizontalPadding = 20.0;
  static const _verticalSpacing = 20.0;
  static const _iconWidth = 20.0;
  static const _opacity = 0.4;
  static const _avatarSize = 40.0;
  static const _emojiSize = 18.0;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;

    final divider = Divider(
      color: blackAndWhite.withOpacity(_opacity),
    );

    return LightStatusBar(
      child: stateObserver(
        builder: (context, state) => Container(
          padding: EdgeInsets.only(
            left: _horizontalPadding,
            right: _horizontalPadding,
            bottom: bottomNavBarHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(_verticalSpacing),
              Text(
                appLocalizations.chatSettingsTitle,
                style: theme.styles.title30,
              ),
              PicnicListItem(
                title: state.circleName,
                leftGap: 0,
                trailingGap: 0,
                titleStyle: theme.styles.title20,
                onTap: presenter.onTapCirclePage,
                leading: PicnicCircleAvatar(
                  emoji: state.circleEmoji,
                  image: state.circleImage,
                  avatarSize: _avatarSize,
                  emojiSize: _emojiSize,
                ),
                trailing: Text(
                  appLocalizations.membersCount(state.membersCount),
                  style: theme.styles.body20.copyWith(color: blackAndWhite.shade600),
                ),
              ),
              divider,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PicnicActionButton(
                    icon: Image.asset(Assets.images.share.path, width: _iconWidth),
                    label: appLocalizations.shareAction,
                    onTap: presenter.onTapShare,
                  ),
                  PicnicActionButton(
                    icon: Image.asset(Assets.images.report.path, width: _iconWidth),
                    label: appLocalizations.reportAction,
                    onTap: presenter.onTapReport,
                  ),
                  if (!state.isMuted)
                    PicnicActionButton(
                      icon: Image.asset(Assets.images.mute.path, width: _iconWidth),
                      label: appLocalizations.muteAction,
                      onTap: presenter.onTapMute,
                    ),
                  if (state.isMuted)
                    PicnicActionButton(
                      icon: Image.asset(Assets.images.unmute.path, width: _iconWidth),
                      label: appLocalizations.unmuteAction,
                      onTap: presenter.onTapUnMute,
                    ),
                  PicnicActionButton(
                    label: state.isJoined ? appLocalizations.leaveAction : appLocalizations.joinAction,
                    onTap: state.isJoined ? presenter.onTapLeave : presenter.onTapJoinCircle,
                    icon: Image.asset(state.isJoined ? Assets.images.logout.path : Assets.images.login.path),
                  ),
                ],
              ),
              const Gap(_verticalSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: PicnicButton(
                        title: appLocalizations.circleChatSettingsCirclePageAction,
                        onTap: presenter.onTapCirclePage,
                        minWidth: double.infinity,
                        color: theme.colors.pink.shade500,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(_verticalSpacing),
              Center(
                child: PicnicTextButton(
                  label: appLocalizations.closeAction,
                  onTap: presenter.onTapClose,
                ),
              ),
              const Gap(_verticalSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
