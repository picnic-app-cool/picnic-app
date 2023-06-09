import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/pods/domain/model/preview_pod_tab.dart';

class PreviewPodInitialParams {
  const PreviewPodInitialParams({
    required this.pod,
    required this.initialTab,
  });

  final PodApp pod;
  final PreviewPodTab initialTab;
}
