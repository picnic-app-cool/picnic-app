import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_initial_params.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presentation_model.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presenter.dart';
import 'package:picnic_app/features/feed/circles_side_menu/widgets/circles_list.dart';
import 'package:picnic_app/features/feed/circles_side_menu/widgets/circles_side_menu_button.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CirclesSideMenuPage extends StatefulWidget with HasInitialParams {
  const CirclesSideMenuPage({
    super.key,
    required this.initialParams,
  });

  @override
  final CirclesSideMenuInitialParams initialParams;

  @override
  State<CirclesSideMenuPage> createState() => _CirclesSideMenuPageState();
}

class _CirclesSideMenuPageState extends State<CirclesSideMenuPage>
    with PresenterStateMixinAuto<CirclesSideMenuViewModel, CirclesSideMenuPresenter, CirclesSideMenuPage> {
  static const _contentPadding = EdgeInsets.symmetric(horizontal: 26.0);
  static const _dividerPadding = EdgeInsets.symmetric(horizontal: 9.0);
  static const double _badgeSize = 20.0;
  static const double _avatarSize = 38;
  static const _circlesIconSize = 24.0;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final styles = PicnicTheme.of(context).styles;
    final link40 = styles.link40;
    final darkBlue = colors.darkBlue;
    final body10 = styles.body10;
    final viewAllStyle = body10.copyWith(color: darkBlue.shade500);
    final followersStyle = body10.copyWith(color: colors.darkBlue.shade600);

    final user = state.privateProfile.user;
    return DarkStatusBar(
      child: Drawer(
        elevation: 0,
        child: SafeArea(
          bottom: !state.isAndroid,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(6),
              if (state.isAndroid) const Gap(16),
              Padding(
                padding: _contentPadding,
                child: InkWell(
                  onTap: presenter.onTapProfile,
                  child: stateObserver(
                    builder: (context, state) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            PicnicAvatar(
                              onTap: presenter.onTapProfile,
                              size: _avatarSize,
                              boxFit: PicnicAvatarChildBoxFit.cover,
                              imageSource: PicnicImageSource.url(
                                state.privateProfile.profileImageUrl,
                                fit: BoxFit.cover,
                              ),
                              placeholder: () => DefaultAvatar.user(avatarSize: _avatarSize),
                            ),
                            const Gap(8),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      user.fullName.isEmpty ? user.username : user.fullName,
                                      style: styles.title20,
                                    ),
                                    if (state.privateProfile.isVerified) ...[
                                      const Gap(4),
                                      Assets.images.verificationBadgePink.image(width: _badgeSize),
                                    ],
                                  ],
                                ),
                                Text(
                                  user.username.formattedUsername,
                                  style: followersStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (state.followingCount > 0 || state.followersCount > 0) ...[
                          const Gap(16),
                          Row(
                            children: [
                              if (state.followingCount > 0) ...[
                                Text(
                                  state.followingCount.formattingToStat(),
                                  style: body10,
                                ),
                                const Gap(4),
                                Text(
                                  appLocalizations.sideBarFollowing,
                                  style: followersStyle,
                                ),
                                const Gap(16),
                              ],
                              if (state.followersCount > 0) ...[
                                Text(
                                  state.followersCount.formattingToStat(),
                                  style: body10,
                                ),
                                const Gap(4),
                                Text(
                                  appLocalizations.sideBarFollowers,
                                  style: followersStyle,
                                ),
                              ],
                            ],
                          ),
                        ],
                        const Gap(20),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: _dividerPadding,
                child: Divider(
                  height: 1,
                  thickness: 1,
                ),
              ),
              const Gap(20),
              Padding(
                padding: _contentPadding,
                child: Row(
                  children: [
                    Image.asset(
                      Assets.images.sidebarCirclesList.path,
                      height: _circlesIconSize,
                      width: _circlesIconSize,
                    ),
                    const Gap(10),
                    Text(
                      appLocalizations.recentCircles,
                      style: link40,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: presenter.onTapViewCircles,
                      child: Text(
                        appLocalizations.viewAllAction,
                        style: viewAllStyle,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Expanded(
                child: stateObserver(
                  builder: (context, state) => Padding(
                    padding: _contentPadding,
                    child: CirclesList(
                      onTapEnterCircle: presenter.onTapEnterCircle,
                      userCircles: state.lastUsedCircles,
                      loadMore: presenter.onLoadMoreCircles,
                      isLoading: state.isCirclesLoading,
                    ),
                  ),
                ),
              ),
              const Gap(8),
              Padding(
                padding: _contentPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: CirclesSideMenuButton(
                        onTap: presenter.onTapCreateNewCircle,
                        title: appLocalizations.newCircleAction,
                        assetPath: Assets.images.sidebarNewCircle.path,
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: CirclesSideMenuButton(
                        onTap: presenter.onTapSearchCircles,
                        title: appLocalizations.discoveryDiscover,
                        assetPath: Assets.images.sidebarDiscover.path,
                      ),
                    ),
                  ],
                ),
              ),
              if (state.isAndroid) const Gap(25),
            ],
          ),
        ),
      ),
    );
  }
}
