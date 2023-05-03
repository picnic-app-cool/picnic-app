import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/members/members_presentation_model.dart';
import 'package:picnic_app/features/circles/members/members_presenter.dart';
import 'package:picnic_app/features/circles/widgets/full_members_list.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class MembersPage extends StatefulWidget with HasPresenter<MembersPresenter> {
  MembersPage({required this.presenter});

  @override
  final MembersPresenter presenter;

  @override
  State<StatefulWidget> createState() => _MembersPage();
}

class _MembersPage extends State<MembersPage>
    with PresenterStateMixin<MembersPageViewModel, MembersPresenter, MembersPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _controller.addListener(() => presenter.onUserSearch(_controller.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Scaffold(
      appBar: PicnicAppBar(
        backgroundColor: theme.colors.blackAndWhite.shade100,
        titleText: appLocalizations.membersLabel,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: PicnicSoftSearchBar(
                    hintText: appLocalizations.search,
                    controller: _controller,
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
        ],
        body: stateObserver(
          builder: (context, state) {
            return FullMembersList(
              emptyItems: state.members.items.isEmpty && state.directors.items.isEmpty,
              hasMore: state.members.hasNextPage || state.directors.hasNextPage,
              privateProfile: state.privateProfile,
              members: state.members,
              directors: state.directors,
              isLoadingToggleFollow: state.isLoadingToggleFollow,
              loadMore: presenter.onLoadMoreMembers,
              onTapAddRole: () => presenter.onTapAddRole(),
              onTapToggleFollow: presenter.onTapToggleFollow,
              onTapInviteUsers: presenter.onTapInviteUsers,
              onTapViewUserProfile: presenter.onTapViewUserProfile,
              hasPermissionToManageRoles: state.circle.hasPermissionToManageRoles,
              hasPermissionToManageUsers: state.circle.hasPermissionToManageUsers,
              onTapEditRole: presenter.onTapEditRole,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
