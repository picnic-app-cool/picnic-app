import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_initial_params.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presentation_model.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presenter.dart';
import 'package:picnic_app/features/feed/circles_side_menu/widgets/circles_list.dart';
import 'package:picnic_app/features/feed/circles_side_menu/widgets/pod_list.dart';
import 'package:picnic_app/features/profile/private_profile/widgets/profile_horizontal_item.dart';
import 'package:picnic_app/features/profile/widgets/tabs/collections_tab.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
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
  static const _tagRadius = 100.0;
  static const double _badgeSize = 20.0;
  static const double _avatarSize = 48;
  static const _plusIconSize = 18.0;
  static const _searchIconSize = 18.0;
  static const _collectionRadius = 8.0;
  static const _collectionHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    const linearGradientNewTag = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [
        0.0,
        0.4319,
        1.0312,
      ],
      colors: [
        Color(0xFFBE86F5),
        Color(0xFFA76AF5),
        Color(0xFFA497F5),
      ],
    );
    final styles = PicnicTheme.of(context).styles;
    final title40 = styles.title40;
    final link15BlueStyle = styles.link15.copyWith(color: colors.blue);
    final darkBlue = colors.darkBlue;

    final user = state.privateProfile.user;
    return DarkStatusBar(
      child: Drawer(
        elevation: 0,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(6),
                InkWell(
                  onTap: presenter.onTapProfile,
                  child: Row(
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
                      const Gap(4),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            user.fullName.isEmpty ? user.username : user.fullName,
                            style: styles.title30,
                          ),
                          Row(
                            children: [
                              Text(
                                user.username.formattedUsername,
                                style: styles.body15.copyWith(color: colors.darkBlue.shade600),
                              ),
                              if (state.privateProfile.isVerified) ...[
                                const Gap(2),
                                Assets.images.verificationBadgePink.image(width: _badgeSize),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.collectionsTabTitle,
                      style: title40,
                    ),
                    InkWell(
                      onTap: presenter.onTapViewCollections,
                      child: Text(appLocalizations.viewAllAction, style: link15BlueStyle),
                    ),
                  ],
                ),
                SizedBox(
                  height: _collectionHeight,
                  child: stateObserver(
                    builder: (context, state) => CollectionsTab(
                      collections: state.collections,
                      borderRadius: _collectionRadius,
                      onLoadMore: presenter.loadCollection,
                      isLoading: state.isLoadingCollections,
                      onTapCollection: presenter.onTapCollection,
                    ),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.recentCircles,
                      style: title40,
                    ),
                    InkWell(
                      onTap: presenter.onTapViewCircles,
                      child: Text(appLocalizations.viewAllAction, style: link15BlueStyle),
                    ),
                  ],
                ),
                Flexible(
                  child: stateObserver(
                    builder: (context, state) => CirclesList(
                      onTapEnterCircle: presenter.onTapEnterCircle,
                      userCircles: state.lastUsedCircles,
                      loadMore: presenter.onLoadMoreCircles,
                      isLoading: state.isCirclesLoading,
                    ),
                  ),
                ),
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalizations.pods,
                          style: title40,
                        ),
                        const Gap(6),
                        PicnicTag(
                          borderRadius: _tagRadius,
                          title: appLocalizations.newLabel,
                          gradient: linearGradientNewTag,
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                          titleTextStyle: styles.body20.copyWith(
                            color: colors.blackAndWhite.shade100,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: presenter.onTapViewPods,
                      child: Text(appLocalizations.viewAllAction, style: link15BlueStyle),
                    ),
                  ],
                ),
                Flexible(
                  child: stateObserver(
                    builder: (context, state) => PodList(
                      pods: state.savedPods,
                      loadMore: presenter.loadSavedPods,
                      isLoading: state.isLoadingPods,
                    ),
                  ),
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: ProfileHorizontalItem(
                        onTap: presenter.onTapCreateNewCircle,
                        title: appLocalizations.createNewCircle,
                        trailing: Image.asset(
                          Assets.images.add.path,
                          color: darkBlue.shade800,
                          height: _plusIconSize,
                          width: _plusIconSize,
                        ),
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: ProfileHorizontalItem(
                        onTap: presenter.onTapSearchCircles,
                        title: appLocalizations.discoverNewCircle,
                        trailing: Image.asset(
                          Assets.images.search.path,
                          color: darkBlue.shade800,
                          height: _searchIconSize,
                          width: _searchIconSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
