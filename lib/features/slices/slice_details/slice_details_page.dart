import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/widgets/rules_tab.dart';
import 'package:picnic_app/features/create_slice/presentation/widgets/private_slice.dart';
import 'package:picnic_app/features/slices/domain/model/slice_details_tab.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_presentation_model.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_presenter.dart';
import 'package:picnic_app/features/slices/slice_details/widgets/slice_details_header.dart';
import 'package:picnic_app/features/slices/slice_details/widgets/slice_tabs.dart';
import 'package:picnic_app/features/slices/slice_info_view.dart';
import 'package:picnic_app/features/slices/widgets/slice_members_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_subtitle.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SliceDetailsPage extends StatefulWidget with HasPresenter<SliceDetailsPresenter> {
  const SliceDetailsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SliceDetailsPresenter presenter;

  @override
  State<SliceDetailsPage> createState() => _SliceDetailsPageState();
}

class _SliceDetailsPageState extends State<SliceDetailsPage>
    with
        PresenterStateMixin<SliceDetailsViewModel, SliceDetailsPresenter, SliceDetailsPage>,
        SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initializeTabController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styleBody10 = theme.styles.body10;

    return stateObserver(
      builder: (context, state) => DarkStatusBar(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PicnicAppBar(
            backgroundColor: colors.blackAndWhite.shade100,
            actions: [
              PicnicContainerIconButton(
                iconPath: Assets.images.moreCircle.path,
                onTap: presenter.onTapMore,
              ),
            ],
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.sliceName, style: theme.styles.body20),
                    const Gap(8),
                    if (state.isPrivate)
                      Image.asset(
                        //TODO add correct icon https://picnic-app.atlassian.net/browse/GS-5225
                        Assets.images.star.path,
                        color: colors.blue,
                      ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PicnicSubtitle(
                      subtitle: appLocalizations.sliceOf,
                      subtitleStyle: styleBody10.copyWith(
                        color: theme.colors.blackAndWhite.shade600,
                      ),
                    ),
                    PicnicSubtitle(
                      subtitle: state.parentCircleName,
                      subtitleStyle: styleBody10.copyWith(
                        color: theme.colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool _) => [
              SliverToBoxAdapter(
                child: SliceDetailsHeader(
                  iJoined: state.iJoined,
                  iRequestedToJoin: state.iRequestedToJoin,
                  onTapChat: presenter.onTapChat,
                  onTapJoin: presenter.onTapJoin,
                  canApproveRequests: state.canApproveRequests,
                  pendingRequestsCount: state.pendingRequestsCount,
                  isPrivate: state.isPrivate,
                ),
              ),
              SliverToBoxAdapter(
                child: SliceTabs(
                  tabController: _tabController,
                  selectedTab: state.selectedTab,
                  tabs: state.tabs,
                ),
              ),
            ],
            body: stateObserver(
              builder: (context, state) => state.isContentHidden
                  ? PrivateSlice()
                  : TabBarView(
                      controller: _tabController,
                      children: state.tabs.map((tab) {
                        switch (tab) {
                          case SliceDetailsTab.members:
                            return SliceMembersView(
                              moderators: state.moderators,
                              users: state.users,
                              onTapSliceModerator: presenter.onTapMember,
                              onTapSliceMember: presenter.onTapMember,
                              loadMore: presenter.loadMoreMembers,
                              isLoading: state.isLoading,
                              onSearchTextChanged: presenter.onSearchTextChanged,
                              onTapInvite: presenter.onTapInviteUsers,
                            );
                          case SliceDetailsTab.circleInfo:
                            return SliceInfoView(
                              circleName: state.parentCircleName,
                              circleEmoji: state.parentCircleEmoji,
                              circleImage: state.parentCircleImage,
                              onTapReport: presenter.onTapReportToCircleOwners,
                              circleRules: state.parentCircleRules,
                            );
                          case SliceDetailsTab.rules:
                            return RulesTab(
                              rules: state.rules,
                              onTapEdit: presenter.onTapEditRules,
                              isMod: state.canEditRules,
                            );
                        }
                      }).toList(),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _initializeTabController() {
    _tabController = TabController(length: state.tabs.length, vsync: this);
    _tabController.index = state.tabs.indexOf(state.selectedTab);
    _tabController.addListener(() => presenter.onTabChanged(_tabController.index));
  }
}
