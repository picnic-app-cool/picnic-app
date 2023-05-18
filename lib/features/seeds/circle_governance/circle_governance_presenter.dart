import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_details_use_case.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_navigator.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_presentation_model.dart';
import 'package:picnic_app/features/seeds/domain/model/governance.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_governance_use_case.dart';

class CircleGovernancePresenter extends Cubit<CircleGovernanceViewModel> {
  CircleGovernancePresenter(
    super.model,
    this._getGovernanceUseCase,
    this._getCircleDetailsUseCase,
    this._navigator,
  );

  final GetGovernanceUseCase _getGovernanceUseCase;
  final CircleGovernanceNavigator _navigator;
  final GetCircleDetailsUseCase _getCircleDetailsUseCase;

  // ignore: unused_element
  CircleGovernancePresentationModel get _model => state as CircleGovernancePresentationModel;

  Future<void> onInit() async {
    await _getCircleIfNecessary();
    await _getGovernance();
  }

  Future<void> onTapInfo() => _navigator.openAboutElections(const AboutElectionsInitialParams());

  Future<void> onTapVoteForDirector() async {
    await _navigator.openCircleElection(
      CircleElectionInitialParams(
        circle: _model.circle,
        circleId: _model.circleId,
      ),
    );
    await onInit();
  }

  void onTapCandidate(VoteCandidate candidate) {
    _navigator.openProfile(userId: candidate.publicProfile.id);
  }

  Future<Either<DisplayableFailure, Circle>> _getCircleIfNecessary() async {
    if (_model.circle != const Circle.empty()) {
      return success(_model.circle);
    }
    return _getCircleDetailsUseCase
        .execute(circleId: _model.circleId)
        .mapFailure((fail) => fail.displayableFailure())
        .doOn(
          success: (circle) => tryEmit(_model.copyWith(circle: circle)),
          fail: (fail) => _navigator.showError(fail),
        );
  }

  Future<Either<DisplayableFailure, Governance>> _getGovernance() => _getGovernanceUseCase
      .execute(circleId: _model.circle.id) //
      .mapFailure((fail) => fail.displayableFailure())
      .doOn(
        success: (governance) {
          tryEmit(_model.copyWith(governance: governance));
        },
        fail: (fail) => _navigator.showError(fail),
      );
}
