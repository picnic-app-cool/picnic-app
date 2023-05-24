import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_scoped_pod_token_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_navigator.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_pods_use_case.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_initial_params.dart';

class DiscoverPodsPresenter extends Cubit<DiscoverPodsViewModel> {
  DiscoverPodsPresenter(
    super.model,
    this._navigator,
    this._getPodsUseCase,
    this._getUserScopedPodTokenUseCase,
    this._logAnalyticsEventUseCase,
  );

  final DiscoverPodsNavigator _navigator;
  final GetPodsUseCase _getPodsUseCase;
  final GetUserScopedPodTokenUseCase _getUserScopedPodTokenUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  DiscoverPodsPresentationModel get _model => state as DiscoverPodsPresentationModel;

  Future<void> onTapPod(CirclePodApp pod) async {
    await _getUserScopedPodTokenUseCase.execute(podId: pod.app.id).doOn(
          success: (generatedToken) {
            _openPodWebPage(accessToken: generatedToken.jwtToken, pod: pod);
          },
          fail: (fail) => _navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> loadMore({bool fromScratch = false}) async {
    await _getPodsUseCase
        .execute(
          circleId: _model.circleId,
          cursor: _model.pods.nextPageCursor(),
        )
        .doOn(
          success: (pods) {
            tryEmit(_model.copyWith(pods: _model.pods.byAppending(pods)));
          },
          fail: (fail) => _navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> _openPodWebPage({required String accessToken, required CirclePodApp pod}) async {
    final fullPodUrl = Uri.parse(pod.app.url).replace(
      queryParameters: {
        'token': Uri.encodeComponent('Bearer $accessToken'),
        'circleId': _model.circleId.value,
      },
    ).toString();

    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.circlePodWebView,
        targetValue: pod.app.name,
      ),
    );
    await _navigator.openPodWebView(
      PodWebViewInitialParams(
        pod: pod.app.copyWith(url: fullPodUrl),
      ),
    );
  }
}
