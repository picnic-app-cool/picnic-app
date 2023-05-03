// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/profile/followers/followers_presentation_model.dart';
import 'package:picnic_app/features/profile/followers/followers_presenter.dart';
import 'package:picnic_app/features/profile/followers/widgets/followers_list.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FollowersPage extends StatefulWidget with HasPresenter<FollowersPresenter> {
  const FollowersPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final FollowersPresenter presenter;

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage>
    with PresenterStateMixin<FollowersViewModel, FollowersPresenter, FollowersPage> {
  late TextEditingController controller;

  static const _padding = EdgeInsets.symmetric(horizontal: 16.0);

  @override
  void initState() {
    controller = TextEditingController();
    controller.addListener(() => presenter.onUserSearch(controller.text));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return DarkStatusBar(
      child: Scaffold(
        appBar: PicnicAppBar(
          backgroundColor: theme.colors.blackAndWhite.shade100,
          titleText: appLocalizations.followersTitle,
          onTapBack: presenter.onTapBack,
        ),
        body: stateObserver(
          builder: (context, state) => Padding(
            padding: _padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: _padding,
                  child: PicnicSoftSearchBar(
                    hintText: appLocalizations.search,
                    controller: controller,
                  ),
                ),
                const Gap(16),
                FollowersList(
                  onTapViewUserProfile: presenter.onTapViewUserProfile,
                  followers: state.followers,
                  loadMoreFollowers: presenter.loadFollowers,
                  onTapToggleFollow: presenter.onTapToggleFollow,
                  privateProfile: state.privateProfile,
                  isLoadingOnToggle: state.isLoadingToggleFollow,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
