import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/followers/widgets/follower_list_item.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class FollowersList extends StatelessWidget {
  const FollowersList({
    Key? key,
    required this.followers,
    required this.loadMoreFollowers,
    required this.onTapToggleFollow,
    required this.onTapViewUserProfile,
    required this.privateProfile,
    this.isLoadingOnToggle = false,
  }) : super(key: key);

  final PaginatedList<PublicProfile> followers;

  final Future<void> Function() loadMoreFollowers;
  final Function(PublicProfile) onTapToggleFollow;
  final Function(Id) onTapViewUserProfile;
  final PrivateProfile privateProfile;
  final bool isLoadingOnToggle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PicnicPagingListView<PublicProfile>(
        paginatedList: followers,
        loadMore: loadMoreFollowers,
        loadingBuilder: (_) => const PicnicLoadingIndicator(),
        itemBuilder: (context, follower) {
          return FollowerListItem(
            onTapToggleFollow: onTapToggleFollow,
            onTapViewUserProfile: onTapViewUserProfile,
            privateProfile: privateProfile,
            follower: follower,
          );
        },
      ),
    );
  }
}
