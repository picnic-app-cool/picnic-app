import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_initial_params.dart';
import 'package:picnic_app/features/circles/domain/use_cases/resolve_report_use_case.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_initial_params.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_navigator.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_presentation_model.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_initial_params.dart';

class ReportedMessagePresenter extends Cubit<ReportedMessageViewModel> {
  ReportedMessagePresenter(
    ReportedMessagePresentationModel model,
    this._resolveReportUseCase,
    this.navigator,
  ) : super(model);

  final ReportedMessageNavigator navigator;
  final ResolveReportUseCase _resolveReportUseCase;

  // ignore: unused_element
  ReportedMessagePresentationModel get _model => state as ReportedMessagePresentationModel;

  void onTapClose() => navigator.close();

  Future<void> onTapBanUser() async {
    final userBanned = await navigator.openBanUser(
      BanUserInitialParams(user: _model.reportedMessageAuthor, circleId: _model.circleId),
    );
    if (userBanned == true) {
      await _resolveReport();
    }
  }

  Future<void> onTapRemove() async {
    final removeReason = await navigator.openRemoveReason(const RemoveReasonInitialParams());
    if (removeReason != null) {
      await _resolveReport(
        fullFill: true,
      );
    }
  }

  Future<void> onTapResolveWithNoAction() async {
    final resolvedWithNoAction = await navigator.openResolveReportWithNoAction(
      ResolveReportWithNoActionInitialParams(
        circleId: _model.circleId,
        reportId: _model.reportId,
      ),
    );
    if (resolvedWithNoAction == true) {
      await _resolveReport();
    }
  }

  // TODO(GS-8035): Call API for removing the post and navigate back with a [true] : https://picnic-app.atlassian.net/browse/GS-8035
  Future<void> _resolveReport({bool fullFill = false}) async {
    await _resolveReportUseCase
        .execute(
          circleId: _model.circleId,
          reportId: _model.reportId,
          fullFill: fullFill,
        )
        .doOn(
          success: (success) {
            navigator.closeWithResult(true);

            //close bottom sheet with resolution options, to prevent calling the use case multiple times
            navigator.close();
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }
}
