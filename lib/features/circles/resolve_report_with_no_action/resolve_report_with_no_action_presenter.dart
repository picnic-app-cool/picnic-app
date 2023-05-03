import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_navigator.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_presentation_model.dart';

class ResolveReportWithNoActionPresenter extends Cubit<ResolveReportWithNoActionViewModel> {
  ResolveReportWithNoActionPresenter(
    super.model,
    this.navigator,
  );

  final ResolveReportWithNoActionNavigator navigator;

  // ignore: unused_element
  ResolveReportWithNoActionPresentationModel get _model => state as ResolveReportWithNoActionPresentationModel;

  void onTapResolveWithNoAction() => navigator.closeWithResult(true);

  void onTapClose() => navigator.closeWithResult(false);
}
