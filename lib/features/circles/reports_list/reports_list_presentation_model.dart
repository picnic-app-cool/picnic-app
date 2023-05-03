import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/utils/paginated_list_presenter/paginated_list_presentation_model.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/circles/domain/model/violation_report.dart';
import 'package:picnic_app/features/circles/reports_list/models/circle_reports_filter_by.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ReportsListPresentationModel implements ReportsListViewModel {
  /// Creates the initial state
  ReportsListPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ReportsListInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : circle = initialParams.circle,
        reports = PaginatedListPresentationModel(),
        onCircleUpdatedCallback = initialParams.onCircleUpdated,
        onCirclePostDeletedCallback = initialParams.onCirclePostDeleted,
        featureFlags = featureFlagsStore.featureFlags,
        filterBy = CircleReportsFilterBy.unresolved;

  /// Used for the copyWith method
  ReportsListPresentationModel._({
    required this.circle,
    required this.reports,
    required this.onCirclePostDeletedCallback,
    required this.onCircleUpdatedCallback,
    required this.featureFlags,
    required this.filterBy,
  });

  final VoidCallback? onCirclePostDeletedCallback;

  final VoidCallback? onCircleUpdatedCallback;

  final FeatureFlags featureFlags;

  @override
  final Circle circle;

  @override
  final PaginatedListPresentationModel<ViolationReport> reports;

  @override
  final CircleReportsFilterBy filterBy;

  @override
  bool get filtersEnabled => featureFlags[FeatureFlagType.filterReportsEnabled];

  @override
  bool get searchEnabled => featureFlags[FeatureFlagType.searchReportsEnabled];

  ReportsListPresentationModel copyWith({
    Circle? circle,
    PaginatedListPresentationModel<ViolationReport>? reports,
    VoidCallback? onCircleUpdatedCallback,
    VoidCallback? onCirclePostDeletedCallback,
    FeatureFlags? featureFlags,
    CircleReportsFilterBy? filterBy,
  }) {
    return ReportsListPresentationModel._(
      circle: circle ?? this.circle,
      reports: reports ?? this.reports,
      onCirclePostDeletedCallback: onCirclePostDeletedCallback ?? this.onCirclePostDeletedCallback,
      onCircleUpdatedCallback: onCircleUpdatedCallback ?? this.onCircleUpdatedCallback,
      featureFlags: featureFlags ?? this.featureFlags,
      filterBy: filterBy ?? this.filterBy,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ReportsListViewModel {
  PaginatedListPresentationModel<ViolationReport> get reports;

  Circle get circle;

  bool get searchEnabled;

  bool get filtersEnabled;

  CircleReportsFilterBy get filterBy;
}
