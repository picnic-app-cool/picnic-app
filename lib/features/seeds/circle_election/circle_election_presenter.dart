import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_details_use_case.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_navigator.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presentation_model.dart';
import 'package:picnic_app/features/seeds/domain/model/election.dart';
import 'package:picnic_app/features/seeds/domain/model/election_candidate.dart';
import 'package:picnic_app/features/seeds/domain/model/get_election_candidates_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_director_failure.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_election_candidates_use_case.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_election_use_case.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/vote_director_use_case.dart';

class CircleElectionPresenter extends Cubit<CircleElectionViewModel> {
  CircleElectionPresenter(
    CircleElectionPresentationModel model,
    this.navigator,
    this._voteDirectorUseCase,
    this._getElectionCandidatesUseCase,
    this._getElectionUseCase,
    this._getCircleDetailsUseCase,
  ) : super(model);

  final CircleElectionNavigator navigator;
  final VoteDirectorUseCase _voteDirectorUseCase;
  final GetElectionUseCase _getElectionUseCase;
  final GetElectionCandidatesUseCase _getElectionCandidatesUseCase;
  final GetCircleDetailsUseCase _getCircleDetailsUseCase;

  // ignore: unused_element
  CircleElectionPresentationModel get _model => state as CircleElectionPresentationModel;

  Future<void> onInit() async {
    await _getCircleIfNecessary();
    await _getElection();
  }

  void onTapDirector(ElectionCandidate director) => tryEmit(
        _model.copyWith(
          selectedCandidate: _model.selectedCandidate.item == director
              ? _model.selectedCandidate.copyWith(selected: !_model.selectedCandidate.selected)
              : Selectable(item: director, selected: true),
        ),
      );

  Future<void> onTapInfo() => navigator.openAboutElections(const AboutElectionsInitialParams());

  Future<Either<VoteDirectorFailure, Id>> onVoteForDirector() => _voteDirectorUseCase
      .execute(
        electionId: _model.election.id,
        userId: _model.selectedCandidate.item.userId,
      ) //
      .doOn(
        success: (e) {
          tryEmit(
            _model.copyWith(
              election: _model.election.copyWith(iVoted: true),
              selectedCandidate: const Selectable(item: ElectionCandidate.empty()),
            ),
          );

          onGetElectionCandidates(fromScratch: true);
          _getElection();
        },
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  Future<Either<GetElectionCandidatesFailure, PaginatedList<ElectionCandidate>>> onGetElectionCandidates({
    bool fromScratch = false,
  }) =>
      _getElectionCandidatesUseCase
          .execute(
            circleId: _model.circleId,
            nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.candidates.nextPageCursor(),
          ) //
          .doOn(
            success: (candidates) => tryEmit(
              fromScratch
                  ? _model.copyWith(candidates: candidates)
                  : _model.byAppendingCandidatesList(
                      newList: candidates,
                    ),
            ),
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );

  void onSearch(String query) => notImplemented();

  Future<Either<DisplayableFailure, Circle>> _getCircleIfNecessary() async {
    if (_model.circle != const Circle.empty()) {
      return success(_model.circle);
    }
    return _getCircleDetailsUseCase
        .execute(circleId: _model.circleId)
        .mapFailure((fail) => fail.displayableFailure())
        .doOn(
          success: (circle) => tryEmit(_model.copyWith(circle: circle)),
          fail: (fail) => navigator.showError(fail),
        );
  }

  Future<Either<DisplayableFailure, Election>> _getElection() => _getElectionUseCase
      .execute(circleId: _model.circleId) //
      .mapFailure((fail) => fail.displayableFailure())
      .doOn(
        success: (election) => tryEmit(_model.copyWith(election: election)),
        fail: (fail) => navigator.showError(fail),
      );
}
