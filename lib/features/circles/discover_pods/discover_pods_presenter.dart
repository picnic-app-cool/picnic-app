import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/use_cases/get_auth_token_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_navigator.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_pods_use_case.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_initial_params.dart';

class DiscoverPodsPresenter extends Cubit<DiscoverPodsViewModel> {
  DiscoverPodsPresenter(
    super.model,
    this._navigator,
    this._getPodsUseCase,
    this._getAuthTokenUseCase,
  );

  final DiscoverPodsNavigator _navigator;
  final GetPodsUseCase _getPodsUseCase;
  final GetAuthTokenUseCase _getAuthTokenUseCase;

  // ignore: unused_element
  DiscoverPodsPresentationModel get _model => state as DiscoverPodsPresentationModel;

  Future<void> onTapPod(CirclePodApp pod) async {
    await _getAuthTokenUseCase.execute().doOn(
          success: (authToken) {
            _openPodWebPage(accessToken: authToken.accessToken, pod: pod);
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
            tryEmit(_model.copyWith(pods: pods));
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
    await _navigator.openPodWebView(
      PodWebViewInitialParams(
        pod: pod.app.copyWith(url: fullPodUrl),
      ),
    );
  }
}
