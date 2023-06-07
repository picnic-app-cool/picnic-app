import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/posts/post_share/post_share_navigator.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presentation_model.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';

class PostSharePresenter extends Cubit<PostShareViewModel> {
  PostSharePresenter(
    super.model,
    this.navigator,
    this._logAnalyticsEventUseCase,
  );

  final PostShareNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  PostSharePresentationModel get _model => state as PostSharePresentationModel;

  Future<void> onTapReport() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postReportLongTap,
      ),
    );
    await navigator.openReportForm(
      ReportFormInitialParams(
        circleId: _model.post.circle.id,
        entityId: _model.post.id,
        reportEntityType: ReportEntityType.post,
        contentAuthorId: _model.post.author.id,
      ),
    );
  }

  Future<void> onTapShare() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postShareButton,
      ),
    );
    await navigator.shareText(text: _model.post.shareLink);
  }
}
