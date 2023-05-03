import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/reports/domain/model/get_report_reasons_failure.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/model/report_reason.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ReportFormPresentationModel implements ReportFormViewModel {
  /// Creates the initial state
  ReportFormPresentationModel.initial(
    ReportFormInitialParams initialParams,
  )   : entityId = initialParams.entityId,
        reportEntityType = initialParams.reportEntityType,
        reasonsResult = const FutureResult.empty(),
        reasonSelected = const ReportReason.empty(),
        description = '',
        circleId = initialParams.circleId,
        contentAuthorId = initialParams.contentAuthorId;

  /// Used for the copyWith method
  ReportFormPresentationModel._({
    required this.entityId,
    required this.reportEntityType,
    required this.reasonsResult,
    required this.reasonSelected,
    required this.description,
    required this.circleId,
    required this.contentAuthorId,
  });

  final Id entityId;
  final Id circleId;
  final Id contentAuthorId;
  final ReportEntityType reportEntityType;
  final FutureResult<Either<GetReportReasonsFailure, List<ReportReason>>> reasonsResult;
  final String description;

  @override
  final ReportReason reasonSelected;

  @override
  bool get isLoading => reasonsResult.isPending();

  @override
  bool get reportEnabled => reasonSelected.reason.isNotEmpty;

  @override
  bool get isShowDescription =>
      reasonSelected.reason.toLowerCase() == appLocalizations.reportReasonOther.toLowerCase() ||
      reasonSelected.reason.toLowerCase() == appLocalizations.reportReasonTechnicalIssue;

  bool get isCircleReport => circleId.value.isNotEmpty;

  List<ReportReason> get reasons => reasonsResult.getSuccess() ?? const [];

  ReportFormPresentationModel copyWith({
    Id? entityId,
    ReportEntityType? reportEntityType,
    FutureResult<Either<GetReportReasonsFailure, List<ReportReason>>>? reasonsResult,
    ReportReason? reasonSelected,
    String? description,
    Id? circleId,
    Id? contentAuthorId,
  }) {
    return ReportFormPresentationModel._(
      entityId: entityId ?? this.entityId,
      reportEntityType: reportEntityType ?? this.reportEntityType,
      reasonsResult: reasonsResult ?? this.reasonsResult,
      reasonSelected: reasonSelected ?? this.reasonSelected,
      description: description ?? this.description,
      circleId: circleId ?? this.circleId,
      contentAuthorId: contentAuthorId ?? this.contentAuthorId,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ReportFormViewModel {
  bool get isLoading;

  ReportReason get reasonSelected;

  bool get reportEnabled;

  bool get isShowDescription;
}
