import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
// ignore: prefer-correct-type-name
class ResolveReportWithNoActionPresentationModel implements ResolveReportWithNoActionViewModel {
  /// Creates the initial state
  ResolveReportWithNoActionPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ResolveReportWithNoActionInitialParams initialParams,
  )   : circleId = initialParams.circleId,
        reportId = initialParams.reportId;

  /// Used for the copyWith method
  ResolveReportWithNoActionPresentationModel._({
    required this.circleId,
    required this.reportId,
  });

  @override
  final Id circleId;

  @override
  final Id reportId;

  ResolveReportWithNoActionPresentationModel copyWith({
    Id? circleId,
    Id? reportId,
  }) {
    return ResolveReportWithNoActionPresentationModel._(
      circleId: circleId ?? this.circleId,
      reportId: reportId ?? this.reportId,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ResolveReportWithNoActionViewModel {
  Id get circleId;

  Id get reportId;
}
