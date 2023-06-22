import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_presenter.dart';
import 'package:picnic_app/features/profile/widgets/profile_container.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/bottom_sheet_top_indicator.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class ProfileBottomSheetPage extends StatefulWidget with HasPresenter<ProfileBottomSheetPresenter> {
  const ProfileBottomSheetPage({
    super.key,
    required this.presenter,
  });

  @override
  final ProfileBottomSheetPresenter presenter;

  @override
  State<ProfileBottomSheetPage> createState() => _ProfileBottomSheetPageState();
}

class _ProfileBottomSheetPageState extends State<ProfileBottomSheetPage>
    with PresenterStateMixin<ProfileBottomSheetViewModel, ProfileBottomSheetPresenter, ProfileBottomSheetPage> {
  static const _heightFactor = 0.6;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final darkBlue = colors.darkBlue;
    final buttonTextStyle = styles.link15.copyWith(color: darkBlue.shade800);
    return FractionallySizedBox(
      heightFactor: _heightFactor,
      child: stateObserver(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      BottomSheetTopIndicator(),
                      const Gap(20),
                      Text(
                        state.publicProfile.username,
                        style: styles.link30.copyWith(color: colors.blackAndWhite.shade900),
                      ),
                      const Gap(20),
                      ProfileContainer(
                        openLink: presenter.openLink,
                        user: state.publicProfile.user,
                        onTap: presenter.onTapStat,
                        profileStats: state.profileStats,
                        isLoadingProfileStats: state.isLoadingProfileStats,
                        onTapCopy: presenter.onTapCopyUserName,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PicnicButton(
                              opacity: 1,
                              title: state.publicProfile.iFollow
                                  ? appLocalizations.followingAction
                                  : appLocalizations.followAction,
                              onTap: () => presenter.onTapAction(state.action),
                              titleStyle: buttonTextStyle,
                              color: darkBlue.shade300,
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            child: PicnicButton(
                              opacity: 1,
                              title: appLocalizations.message,
                              onTap: presenter.onTapDm,
                              titleStyle: buttonTextStyle,
                              color: darkBlue.shade300,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      SizedBox(
                        width: double.infinity,
                        child: PicnicButton(
                          opacity: 1,
                          title: appLocalizations.viewProfile,
                          onTap: presenter.onTapViewProfile,
                          titleStyle: styles.link15.copyWith(color: colors.blackAndWhite.shade100),
                          color: colors.blue,
                        ),
                      ),
                      const Gap(12),
                    ],
                  ),
                  if (state.isLoadingUser || state.isLoadingProfileStats)
                    const Center(
                      child: PicnicLoadingIndicator(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
