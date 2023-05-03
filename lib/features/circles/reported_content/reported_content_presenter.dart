import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/post_report_type.dart';
import 'package:picnic_app/features/circles/domain/use_cases/resolve_report_use_case.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_initial_params.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_navigator.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_presentation_model.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_initial_params.dart';

class ReportedContentPresenter extends Cubit<ReportedContentViewModel> {
  ReportedContentPresenter(
    ReportedContentPresentationModel model,
    this._resolveReportUseCase,
    this.navigator,
  ) : super(model);

  final ReportedContentNavigator navigator;
  final ResolveReportUseCase _resolveReportUseCase;

  // ignore: unused_element
  ReportedContentPresentationModel get _model => state as ReportedContentPresentationModel;

  Future<void> onTapRemove() async {
    final removeReason = await navigator.openRemoveReason(const RemoveReasonInitialParams());
    if (removeReason != null) {
      await _resolveReport(
        fullFill: true,
      );
    }
  }

  Future<void> onTapBan() async {
    final userBanned = await navigator.openBanUser(
      BanUserInitialParams(
        user: _model.postAuthor,
        circleId: _model.circleId,
      ),
    );
    if (userBanned == true) {
      await _resolveReport(
        fullFill: false,
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
      await _resolveReport(
        fullFill: false,
      );
    }
  }

  void onTapClose() => navigator.close();

  Future<void> _resolveReport({required bool fullFill}) async {
    await _resolveReportUseCase
        .execute(
          circleId: _model.circleId,
          reportId: _model.reportId,
          fullFill: fullFill,
        )
        .doOn(
          success: (success) {
            navigator.closeWithResult(PostReportType.postRemoved);

            //close bottom sheet with resolution options, to prevent calling the use case multiple times
            navigator.close();
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }
}
