import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/pods/widgets/minimal_info_pod_widget.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PodsTab extends StatelessWidget {
  const PodsTab({
    Key? key,
    required this.pods,
    required this.onLoadMore,
    required this.onTapPod,
  }) : super(key: key);

  final PaginatedList<PodApp> pods;
  final Future<void> Function() onLoadMore;
  final Function(PodApp) onTapPod;

  @override
  Widget build(BuildContext context) => PicnicPagingListView<PodApp>(
        paginatedList: pods,
        loadMore: onLoadMore,
        loadingBuilder: (_) => const PicnicLoadingIndicator(),
        separatorBuilder: (_, __) => const Gap(10),
        itemBuilder: (context, pod) {
          return MinimalInfoPodWidget(
            pod: pod,
            onTapPod: onTapPod,
          );
        },
      );
}
