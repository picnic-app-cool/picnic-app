import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/discover/widgets/pod.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PodList extends StatelessWidget {
  const PodList({
    Key? key,
    required this.circlePodApps,
    required this.onTapPod,
    required this.onTapSave,
    required this.loadMore,
  }) : super(key: key);

  final PaginatedList<PodApp> circlePodApps;
  final Function(PodApp) onTapPod;
  final Function(Id) onTapSave;

  final Future<void> Function() loadMore;

  static const radius = 16.0;
  static const width = 280.0;
  static const height = 260.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: PicnicPagingListView<PodApp>(
        scrollDirection: Axis.horizontal,
        paginatedList: circlePodApps,
        loadMore: loadMore,
        loadingBuilder: (_) => const PicnicLoadingIndicator(),
        itemBuilder: (context, pod) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Pod(
              pod: pod,
              onTapAddCircle: () => onTapPod(pod),
              width: width,
              onTapSave: () => onTapSave(pod.id),
              onTapView: () => onTapPod(pod),
              height: 0.0,
            ),
          );
        },
      ),
    );
  }
}
