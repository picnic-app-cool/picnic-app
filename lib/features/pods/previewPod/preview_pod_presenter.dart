import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_scoped_pod_token_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_initial_params.dart';
import 'package:picnic_app/features/pods/domain/model/get_recommended_circles_input.dart';
import 'package:picnic_app/features/pods/domain/model/get_recommended_circles_recommendation_kind.dart';
import 'package:picnic_app/features/pods/domain/use_cases/enable_pod_in_circle_use_case.dart';
import 'package:picnic_app/features/pods/domain/use_cases/get_recommended_circles_use_case.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_navigator.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_presentation_model.dart';

class PreviewPodPresenter extends Cubit<PreviewPodViewModel> {
  PreviewPodPresenter(
    super.model,
    this.navigator,
    this._enablePodInCircleUseCase,
    this._getRecommendedCirclesUseCase,
    this._logAnalyticsEventUseCase,
    this._getUserScopedPodTokenUseCase,
    this._debouncer,
  );

  final PreviewPodNavigator navigator;
  final EnablePodInCircleUseCase _enablePodInCircleUseCase;
  final GetRecommendedCirclesUseCase _getRecommendedCirclesUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final GetUserScopedPodTokenUseCase _getUserScopedPodTokenUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  PreviewPodPresentationModel get _model => state as PreviewPodPresentationModel;

  Future<void> loadCirclesThatCanBeLaunched({bool fromScratch = false}) => _getRecommendedCirclesUseCase
      .execute(
        GetRecommendedCirclesInput(
          search: _model.searchQuery,
          cursor: fromScratch
              ? const Cursor.firstPage(pageSize: PreviewPodPresentationModel.circlesPerPage)
              : _model.circlesToLaunchPodInCursor,
          podId: _model.pod.id,
          kind: GetRecommendedCirclesRecommendationKind.launchingPod,
        ),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (list) {
          tryEmit(_model.copyWith(circlesToLaunchPodIn: fromScratch ? list : _model.circlesToLaunchPodIn + list));
        },
      );

  Future<void> loadCirclesToEnablePod({bool fromScratch = false}) => _getRecommendedCirclesUseCase
      .execute(
        GetRecommendedCirclesInput(
          search: _model.searchQuery,
          cursor: fromScratch
              ? const Cursor.firstPage(pageSize: PreviewPodPresentationModel.circlesPerPage)
              : _model.circlesToEnablePodInCursor,
          podId: _model.pod.id,
          kind: GetRecommendedCirclesRecommendationKind.enablingPod,
        ),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (list) =>
            tryEmit(_model.copyWith(circlesToEnablePodIn: fromScratch ? list : _model.circlesToEnablePodIn + list)),
      );

  void onSearchTextChanged(String searchText) {
    if (searchText != _model.searchQuery) {
      _debouncer.debounce(
        const LongDuration(),
        () {
          tryEmit(_model.copyWith(searchQuery: searchText));
          _loadCircles(fromScratch: true);
        },
      );
    }
  }

  Future<void> onTapEnablePodInCircle(Circle circle) async {
    await _enablePodInCircleUseCase
        .execute(
      podId: _model.pod.id,
      circleId: circle.id,
    )
        .doOn(
      success: (_) async {
        await navigator.showPodEnabledSuccessfullyBottomSheet(
          circle: circle,
          pod: _model.pod,
          // ignore: no-empty-block
          onTapLaunch: () => onTapLaunchPodInCircle(circle),
        );
        await _loadCircles(fromScratch: true);
      },
    );
  }

  void onTabChanged(int index) {
    final selectedTab = _model.tabs[index];
    tryEmit(
      _model.copyWith(selectedTab: selectedTab),
    );
  }

  Future<void> onTapLaunchPodInCircle(Circle circle) async {
    await _getUserScopedPodTokenUseCase.execute(podId: _model.pod.id).doOn(
          success: (generatedToken) {
            _openPodWebPage(accessToken: generatedToken.jwtToken, circleId: circle.id);
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> _openPodWebPage({
    required String accessToken,
    required Id circleId,
  }) async {
    final pod = _model.pod;
    final fullPodUrl = Uri.parse(pod.url).replace(
      queryParameters: {
        'token': Uri.encodeComponent('Bearer $accessToken'),
        'circleId': circleId.value,
      },
    ).toString();

    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.circlePodWebView,
        targetValue: pod.name,
      ),
    );
    await navigator.openPodWebView(
      PodWebViewInitialParams(
        pod: pod.copyWith(url: fullPodUrl),
      ),
    );
  }

  Future<void> _loadCircles({bool fromScratch = false}) async {
    await loadCirclesToEnablePod(fromScratch: fromScratch);
    await loadCirclesThatCanBeLaunched(fromScratch: fromScratch);
  }
}
