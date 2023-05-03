import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/reports/domain/model/report_reason.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_navigator.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_presentation_model.dart';

class ReportReasonsPresenter extends Cubit<ReportReasonsViewModel> {
  ReportReasonsPresenter(
    super.model,
    this.navigator,
  );

  final ReportReasonsNavigator navigator;

  // ignore: unused_element
  ReportReasonsPresentationModel get _model => state as ReportReasonsPresentationModel;

  void onTapSelectReason(ReportReason reason) {
    navigator.closeWithResult(reason);
  }
}
