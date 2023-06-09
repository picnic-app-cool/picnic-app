import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/pods/domain/model/preview_pod_tab.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PreviewPodPresentationModel implements PreviewPodViewModel {
  /// Creates the initial state
  PreviewPodPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PreviewPodInitialParams initialParams,
  )   : circlesToLaunchPodIn = const PaginatedList.empty(),
        circlesToEnablePodIn = const PaginatedList.empty(),
        searchQuery = '',
        pod = initialParams.pod,
        selectedTab = initialParams.initialTab;

  /// Used for the copyWith method
  PreviewPodPresentationModel._({
    required this.circlesToLaunchPodIn,
    required this.circlesToEnablePodIn,
    required this.searchQuery,
    required this.pod,
    required this.selectedTab,
  });

  final String searchQuery;
  static const circlesPerPage = 51;

  @override
  final PodApp pod;

  @override
  final PaginatedList<Circle> circlesToLaunchPodIn;

  @override
  final PaginatedList<Circle> circlesToEnablePodIn;

  @override
  final PreviewPodTab selectedTab;

  @override
  List<PreviewPodTab> get tabs {
    return [
      PreviewPodTab.launch,
      PreviewPodTab.addToCircles,
    ];
  }

  Cursor get circlesToLaunchPodInCursor => circlesToLaunchPodIn.nextPageCursor(pageSize: circlesPerPage);

  Cursor get circlesToEnablePodInCursor => circlesToLaunchPodIn.nextPageCursor(pageSize: circlesPerPage);

  PreviewPodPresentationModel copyWith({
    PaginatedList<Circle>? circlesToLaunchPodIn,
    PaginatedList<Circle>? circlesToEnablePodIn,
    String? searchQuery,
    PodApp? pod,
    PreviewPodTab? selectedTab,
  }) {
    return PreviewPodPresentationModel._(
      circlesToLaunchPodIn: circlesToLaunchPodIn ?? this.circlesToLaunchPodIn,
      circlesToEnablePodIn: circlesToEnablePodIn ?? this.circlesToEnablePodIn,
      searchQuery: searchQuery ?? this.searchQuery,
      pod: pod ?? this.pod,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PreviewPodViewModel {
  PaginatedList<Circle> get circlesToLaunchPodIn;

  PaginatedList<Circle> get circlesToEnablePodIn;

  List<PreviewPodTab> get tabs;

  PreviewPodTab get selectedTab;

  PodApp get pod;
}
