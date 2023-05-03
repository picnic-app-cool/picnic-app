import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_navigator.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_presentation_model.dart';

class ResolvedReportDetailsPresenter extends Cubit<ResolvedReportDetailsViewModel> {
  ResolvedReportDetailsPresenter(
    ResolvedReportDetailsPresentationModel model,
    this.navigator,
  ) : super(model);

  final ResolvedReportDetailsNavigator navigator;

  void onTapClose() => navigator.closeWithResult(false);
}
