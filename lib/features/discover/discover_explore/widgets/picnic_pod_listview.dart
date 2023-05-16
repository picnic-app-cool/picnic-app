import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/discover_pods/widgets/pod_widget.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PicnicPodListView extends StatelessWidget {
  const PicnicPodListView({
    Key? key,
    required this.circlePodApps,
    required this.onTapPod,
    required this.loadMore,
  }) : super(key: key);

  final PaginatedList<CirclePodApp> circlePodApps;
  final Function(Id) onTapPod;
  final Future<void> Function() loadMore;

  static const radius = 16.0;
  static const width = 210.0;
  static const height = 280.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: SizedBox(
        height: height,
        child: PicnicPagingListView<CirclePodApp>(
          scrollDirection: Axis.horizontal,
          paginatedList: circlePodApps,
          loadMore: loadMore,
          loadingBuilder: (_) => const PicnicLoadingIndicator(),
          itemBuilder: (context, pod) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: PodWidget(
                pod: pod.app,
                onTap: () => onTapPod(pod.app.id),
                width: width,
                height: height,
              ),
            );
          },
        ),
      ),
    );
  }
}
