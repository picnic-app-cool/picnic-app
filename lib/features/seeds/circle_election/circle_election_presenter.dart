import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_navigator.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presentation_model.dart';
import 'package:picnic_app/features/seeds/domain/model/get_election_candidates_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_director_failure.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_election_candidates_use_case.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/vote_director_use_case.dart';

class CircleElectionPresenter extends Cubit<CircleElectionViewModel> {
  CircleElectionPresenter(
    CircleElectionPresentationModel model,
    this.navigator,
    this._voteDirectorUseCase,
    this._getElectionCandidatesUseCase,
    this._debouncer,
  ) : super(model);

  final CircleElectionNavigator navigator;
  final VoteDirectorUseCase _voteDirectorUseCase;
  final GetElectionCandidatesUseCase _getElectionCandidatesUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  CircleElectionPresentationModel get _model => state as CircleElectionPresentationModel;

  void onTapDirector(VoteCandidate director) => tryEmit(
        _model.copyWith(
          selectedCandidate: _model.selectedCandidate.item == director
              ? _model.selectedCandidate.copyWith(selected: !_model.selectedCandidate.selected)
              : Selectable(item: director, selected: true),
        ),
      );

  Future<void> onTapInfo() => navigator.openAboutElections(const AboutElectionsInitialParams());

  Future<Either<VoteDirectorFailure, Id>> onVoteForDirector() => _voteDirectorUseCase
      .execute(
        circleId: _model.circleId,
        userId: _model.selectedCandidate.item.userId,
      ) //
      .doOn(
        success: (e) {
          tryEmit(
            _model.copyWith(
              selectedCandidate: const Selectable(item: VoteCandidate.empty()),
            ),
          );
          onGetElectionCandidates(fromScratch: true);
        },
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  Future<Either<GetElectionCandidatesFailure, PaginatedList<VoteCandidate>>> onGetElectionCandidates({
    bool fromScratch = false,
  }) =>
      _getElectionCandidatesUseCase
          .execute(
            circleId: _model.circleId,
            nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.candidates.nextPageCursor(),
            searchQuery: _model.searchQuery,
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

  void onUserSearch(String searchQuery) {
    if (searchQuery != _model.searchQuery) {
      _debouncer.debounce(
        const LongDuration(),
        () {
          tryEmit(_model.copyWith(searchQuery: searchQuery));
          _loadCandidates(fromScratch: true, searchQuery: searchQuery);
        },
      );
    }
  }

  void _loadCandidates({
    bool fromScratch = false,
    String searchQuery = '',
  }) =>
      _getElectionCandidatesUseCase
          .execute(
            circleId: _model.circleId,
            nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.candidates.nextPageCursor(),
            searchQuery: searchQuery,
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
}
