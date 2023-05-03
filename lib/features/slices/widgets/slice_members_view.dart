import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/circles/domain/model/slice_member.dart';
import 'package:picnic_app/features/slices/widgets/slice_header_view.dart';
import 'package:picnic_app/features/slices/widgets/slice_members_list.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/load_more_scroll_notification.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

//ignore_for_file: unused-code, unused-files
class SliceMembersView extends StatelessWidget {
  const SliceMembersView({
    Key? key,
    required this.moderators,
    required this.users,
    required this.onTapSliceModerator,
    required this.onTapSliceMember,
    required this.loadMore,
    required this.isLoading,
    required this.onSearchTextChanged,
    this.onTapInvite,
    this.onTapFollow,
  }) : super(key: key);

  final PaginatedList<SliceMember> moderators;
  final PaginatedList<SliceMember> users;
  final Function(SliceMember) onTapSliceModerator;
  final Function(SliceMember) onTapSliceMember;
  final VoidCallback? onTapInvite;
  final Function(SliceMember)? onTapFollow;
  final Future<void> Function() loadMore;
  final bool isLoading;
  final Function(String) onSearchTextChanged;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return LoadMoreScrollNotification(
      emptyItems: moderators.items.isEmpty && users.items.isEmpty,
      hasMore: moderators.hasNextPage || users.hasNextPage,
      loadMore: loadMore,
      builder: (context) {
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Gap(20),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: PicnicSoftSearchBar(
                  onChanged: onSearchTextChanged,
                  hintText: appLocalizations.searchUserLabel,
                  hintTextStyle: theme.styles.body10.copyWith(color: theme.colors.blackAndWhite.shade900),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Gap(8),
            ),
            SliverToBoxAdapter(
              child: SliceHeaderView(
                title: appLocalizations.modsAndDirectorTitle,
                buttonText: appLocalizations.inviteAction,
                onTapInvite: onTapInvite,
              ),
            ),
            SliceMembersList(
              title: appLocalizations.modsAndDirectorTitle,
              sliceMembers: moderators,
              onSliceMemberTap: onTapSliceModerator,
            ),
            const SliverToBoxAdapter(
              child: Gap(20),
            ),
            SliverToBoxAdapter(
              child: SliceHeaderView(
                title: appLocalizations.users,
                buttonText: appLocalizations.addAction,
              ),
            ),
            SliceMembersList(
              title: appLocalizations.users,
              sliceMembers: users,
              onSliceMemberTap: onTapSliceMember,
              onTapFollow: onTapFollow,
            ),
            if (isLoading)
              const SliverFillRemaining(
                child: Center(
                  child: PicnicLoadingIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}
