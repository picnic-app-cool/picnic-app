import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_seeds_use_case.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presentation_model.dart';

class SellSeedsFirstStepPresenter extends Cubit<SellSeedsFirstStepViewModel> {
  SellSeedsFirstStepPresenter(
    SellSeedsFirstStepPresentationModel model,
    this.navigator,
    this._getSeedsUseCase,
    this._debouncer,
  ) : super(model);

  final SellSeedsNavigator navigator;
  final GetSeedsUseCase _getSeedsUseCase;
  final Debouncer _debouncer;

  SellSeedsFirstStepPresentationModel get _model => state as SellSeedsFirstStepPresentationModel;

  void onTapChoose(Seed seed) => _model.onChooseCircle(seed);

  //TODO: (search query) https://picnic-app.atlassian.net/browse/GS-6875 - add query parameter to document
  void onSeedSearch(String query) {
    if (query == _model.search) {
      return;
    }

    tryEmit(_model.copyWith(search: query));
    _debouncer.debounce(
      const LongDuration(),
      () => getSeeds(fromScratch: true),
    );
  }

  Future<void> getSeeds({
    bool fromScratch = false,
  }) async {
    final cursor = fromScratch ? const Cursor.firstPage() : _model.seeds.nextPageCursor();

    await _getSeedsUseCase
        .execute(
          nextPageCursor: cursor,
          circleId: _model.circleId,
        )
        .doOn(
          success: (seeds) {
            final newList = fromScratch ? seeds : _model.seeds + seeds;
            tryEmit(_model.copyWith(seeds: newList));
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }
}
