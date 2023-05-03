import 'package:picnic_app/features/reports/domain/model/report_reason.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ReportReasonsPresentationModel implements ReportReasonsViewModel {
  /// Creates the initial state
  ReportReasonsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ReportReasonsInitialParams initialParams,
  ) : reasons = initialParams.reasons;

  /// Used for the copyWith method
  ReportReasonsPresentationModel._({
    required this.reasons,
  });

  @override
  final List<ReportReason> reasons;

  ReportReasonsPresentationModel copyWith({
    List<ReportReason>? reasons,
  }) {
    return ReportReasonsPresentationModel._(
      reasons: reasons ?? this.reasons,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ReportReasonsViewModel {
  List<ReportReason> get reasons;
}
