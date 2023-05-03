import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/picnic_stat.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_presenter.dart';
import 'package:picnic_app/features/circles/circle_member_settings/widgets/edit_roles_button.dart';
import 'package:picnic_app/features/circles/circle_member_settings/widgets/profile_widget.dart';
import 'package:picnic_app/features/circles/circle_member_settings/widgets/roles_horizontal_container.dart';
import 'package:picnic_app/features/profile/public_profile/widgets/public_profile_buttons.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_stats.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class CircleMemberSettingsPage extends StatefulWidget with HasPresenter<CircleMemberSettingsPresenter> {
  const CircleMemberSettingsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CircleMemberSettingsPresenter presenter;

  @override
  State<CircleMemberSettingsPage> createState() => _CircleMemberSettingsPageState();
}

class _CircleMemberSettingsPageState extends State<CircleMemberSettingsPage>
    with PresenterStateMixin<CircleMemberSettingsViewModel, CircleMemberSettingsPresenter, CircleMemberSettingsPage> {
  @override
  void initState() {
    super.initState();

    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: stateObserver(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileWidget(
              publicProfile: state.publicProfile,
            ),
            if (state.roles.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  34,
                  0,
                  34,
                  12,
                ),
                child: state.isLoadingRoles
                    ? const Center(child: PicnicLoadingIndicator())
                    : AnimatedOpacity(
                        opacity: state.isLoadingRoles ? 0.0 : 1.0,
                        duration: const ShortDuration(),
                        curve: Curves.easeInOut,
                        child: RolesHorizontalContainer(
                          roles: state.roles,
                        ),
                      ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: PicnicStats(
                onTap: presenter.onTapStatType,
                stats: [
                  PicnicStat(
                    type: StatType.likes,
                    count: state.profileStats.likes,
                  ),
                  PicnicStat(
                    type: StatType.followers,
                    count: state.profileStats.followers,
                  ),
                  PicnicStat(
                    type: StatType.views,
                    count: state.profileStats.views,
                  ),
                ],
                isLoading: state.isLoadingProfileStats,
              ),
            ),
            const Gap(16),
            if (!state.isMe)
              PublicProfileButtons(
                action: state.action,
                onTapDM: presenter.onTapDm,
                onTapAction: () => state.isLoadingToggleFollow ? null : presenter.onTapAction(state.action),
                isBlocked: state.isBlocked,
              ),
            if (state.hasPermissionToManageUsers) ...[
              const Gap(12),
              EditRolesButton(onTap: presenter.onTapEditRoles),
            ],
            const Gap(12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                height: 1,
              ),
            ),
            Center(
              child: PicnicTextButton(
                label: appLocalizations.closeAction,
                onTap: presenter.onTapClose,
                labelStyle: PicnicTheme.of(context).styles.caption20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
