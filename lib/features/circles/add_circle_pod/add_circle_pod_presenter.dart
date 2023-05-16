import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/use_cases/get_post_creation_circles_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_navigator.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_presentation_model.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_initial_params.dart';

class AddCirclePodPresenter extends Cubit<AddCirclePodViewModel> {
  AddCirclePodPresenter(
    super.model,
    this.navigator,
    this._getPostCreationCirclesUseCase,
    this._debouncer,
  );

  final AddCirclePodNavigator navigator;

  final GetPostCreationCirclesUseCase _getPostCreationCirclesUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  AddCirclePodPresentationModel get _model => state as AddCirclePodPresentationModel;

  void searchChanged(String search) {
    tryEmit(_model.copyWith(searchQuery: search));
    _debouncer.debounce(
      const LongDuration(),
      () => _loadCircles(fromScratch: true),
    );
  }

  Future<void> loadMore() async => _loadCircles(fromScratch: false);

  void onTapCircle(Circle circle) => navigator.openDiscoverPods(DiscoverPodsInitialParams(circleId: circle.id));

  Future<void> _loadCircles({required bool fromScratch}) async {
    await _getPostCreationCirclesUseCase
        .execute(
          searchQuery: _model.searchQuery,
        ) //
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(getCirclesFutureResult: result)),
        )
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (list) =>
              fromScratch ? tryEmit(_model.copyWith(circles: list)) : tryEmit(_model.byAppendingCircles(list)),
        );
  }
}
