import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/slices/join_requests/widgets/join_request_list_item.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class JoinRequestsList extends StatelessWidget {
  const JoinRequestsList({
    Key? key,
    required this.requests,
    required this.loadMoreRequests,
    required this.onTapApprove,
    required this.onTapViewUserProfile,
    this.isApproveLoading = false,
  }) : super(key: key);

  final PaginatedList<PublicProfile> requests;

  final Future<void> Function() loadMoreRequests;
  final Function(PublicProfile) onTapApprove;
  final Function(Id) onTapViewUserProfile;
  final bool isApproveLoading;

  @override
  Widget build(BuildContext context) {
    return PicnicPagingListView<PublicProfile>(
      paginatedList: requests,
      loadMore: loadMoreRequests,
      loadingBuilder: (_) => const PicnicLoadingIndicator(),
      itemBuilder: (context, userProfile) {
        return JoinRequestListItem(
          onTapApprove: onTapApprove,
          onTapViewUserProfile: onTapViewUserProfile,
          userProfile: userProfile,
        );
      },
    );
  }
}
