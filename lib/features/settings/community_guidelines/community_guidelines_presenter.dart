import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_navigator.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_presentation_model.dart';

class CommunityGuidelinesPresenter extends Cubit<CommunityGuidelinesViewModel> {
  CommunityGuidelinesPresenter(
    CommunityGuidelinesPresentationModel model,
    this.navigator,
  ) : super(model);

  final CommunityGuidelinesNavigator navigator;

  // ignore: unused_element
  CommunityGuidelinesPresentationModel get _model => state as CommunityGuidelinesPresentationModel;

  void onTapLink({String? href}) {
    if (href != null) {
      if (href == 'report') {
        navigator.openReportForm(const ReportFormInitialParams());
      } else {
        debugLog('Link ignored: $href');
      }
    }
  }
}
