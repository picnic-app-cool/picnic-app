import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/un_vote_pod_failure.dart';
import 'package:picnic_app/features/circles/domain/model/vote_pod_failure.dart';
import 'package:picnic_app/features/circles/domain/use_cases/un_vote_pod_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/vote_pod_use_case.dart';
import 'package:picnic_app/features/pods/domain/use_cases/save_pod_use_case.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_presentation_model.dart';

class PodBottomSheetPresenter extends Cubit<PodBottomSheetViewModel> {
  PodBottomSheetPresenter(
    super.model,
    this.navigator,
    this._votePodUseCase,
    this._savePodUseCase,
    this._unVotePodUseCase,
  );

  final PodBottomSheetNavigator navigator;
  final VotePodUseCase _votePodUseCase;
  final UnVotePodUseCase _unVotePodUseCase;

  // ignore: unused_field
  final SavePodUseCase _savePodUseCase;

  // ignore: unused_element
  PodBottomSheetPresentationModel get _model => state as PodBottomSheetPresentationModel;

  Future<Either<VotePodFailure, Unit>> onVote({required PodApp pod}) {
    final upvotes = _model.pod.counters.upvotes;

    return _votePodUseCase
        .execute(
          podId: pod.id,
        ) //
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (result) {
            tryEmit(
              _model.byUpdatingPod(
                pod: pod.copyWith(
                  iUpvoted: true,
                  counters: _model.pod.counters.copyWith(
                    upvotes: upvotes + 1,
                  ),
                ),
              ),
            );
            navigator.closeWithResult(_model.pod);
          },
        );
  }

  Future<Either<UnVotePodFailure, Unit>> onUnVote({required PodApp pod}) {
    final upvotes = _model.pod.counters.upvotes;

    return _unVotePodUseCase
        .execute(
          podId: pod.id,
        ) //
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (result) {
            tryEmit(
              _model.byUpdatingPod(
                pod: pod.copyWith(
                  iUpvoted: false,
                  counters: _model.pod.counters.copyWith(
                    upvotes: upvotes - 1,
                  ),
                ),
              ),
            );
            navigator.closeWithResult(_model.pod);
          },
        );
  }

  void onTapAddToCircle(PodApp pod) {
    navigator.openAddCirclePod(AddCirclePodInitialParams(podId: pod.id));
  }

  Future<void> onTapSavePod(Id podId) async {
    await _savePodUseCase
        .execute(
          podId: podId,
        )
        .doOn(
          success: (result) => tryEmit(_model.copyWith(pod: _model.pod.copyWith(iSaved: true))),
        );
  }
}
