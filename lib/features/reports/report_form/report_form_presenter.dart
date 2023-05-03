import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/reports/domain/model/circle_report_reason.dart';
import 'package:picnic_app/features/reports/domain/model/create_report_input.dart';
import 'package:picnic_app/features/reports/domain/model/report_input.dart';
import 'package:picnic_app/features/reports/domain/use_cases/create_circle_report_use_case.dart';
import 'package:picnic_app/features/reports/domain/use_cases/create_global_report_use_case.dart';
import 'package:picnic_app/features/reports/domain/use_cases/get_circle_report_reasons_use_case.dart';
import 'package:picnic_app/features/reports/domain/use_cases/get_global_report_reasons_use_case.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_presentation_model.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class ReportFormPresenter extends Cubit<ReportFormViewModel> {
  ReportFormPresenter(
    super.model,
    this.navigator,
    this._getGlobalReasonsUseCase,
    this._getCircleReasonsUseCase,
    this._createGlobalReportUseCase,
    this._createCircleReportUseCase,
  );

  final ReportFormNavigator navigator;
  final GetGlobalReportReasonsUseCase _getGlobalReasonsUseCase;
  final GetCircleReportReasonsUseCase _getCircleReasonsUseCase;
  final CreateGlobalReportUseCase _createGlobalReportUseCase;
  final CreateCircleReportUseCase _createCircleReportUseCase;

  // ignore: unused_element
  ReportFormPresentationModel get _model => state as ReportFormPresentationModel;

  void onInit() {
    _getReasons();
  }

  Future<void> onTapDisplayReasons() async {
    final reasonSelected = await navigator.openReportReasons(
      ReportReasonsInitialParams(
        reasons: _model.reasons,
      ),
    );

    if (reasonSelected != null) {
      tryEmit(_model.copyWith(reasonSelected: reasonSelected));
    }
  }

  void onChangedDescription(String description) => tryEmit(_model.copyWith(description: description));

  void onTapSendReport() {
    if (_model.isCircleReport) {
      _reportInCircle();
    } else {
      _reportGlobally();
    }
  }

  void _reportGlobally() {
    _createGlobalReportUseCase
        .execute(
          report: CreateReportInput(
            entityId: _model.entityId,
            entity: _model.reportEntityType,
            reason: _model.reasonSelected.reason,
            description: _model.description,
          ),
        )
        .doOn(
          success: (_) => _showSuccess(),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void _reportInCircle() {
    _createCircleReportUseCase
        .execute(
          report: ReportInput(
            anyId: _model.entityId,
            circleId: _model.circleId,
            reportType: _model.reportEntityType,
            reason: CircleReportReason.fromString(_model.reasonSelected.reason).value,
            comment: _model.description,
            contentAuthorId: _model.contentAuthorId,
          ),
        )
        .doOn(
          success: (_) => _showSuccess(),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void _showSuccess() => navigator.showConfirmationAlert(
        title: appLocalizations.thankYouTitle,
        description: appLocalizations.reportConfirmationMessage,
        buttonLabel: appLocalizations.awesomeAction,
        iconEmoji: '📫',
        onTap: () => navigator.closeWithResult(true),
      );

  void _getReasons() {
    if (_model.isCircleReport) {
      _getCircleReportReasons();
    } else {
      _getGlobalReportReasons();
    }
  }

  void _getGlobalReportReasons() => _getGlobalReasonsUseCase
      .execute(
        reportEntityType: _model.reportEntityType,
      )
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(reasonsResult: result)),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void _getCircleReportReasons() => _getCircleReasonsUseCase
      .execute()
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(reasonsResult: result)),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );
}
