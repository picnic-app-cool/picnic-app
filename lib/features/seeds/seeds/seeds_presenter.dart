import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_seeds_use_case.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_navigator.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_initial_params.dart';

class SeedsPresenter extends Cubit<SeedsViewModel> {
  SeedsPresenter(
    SeedsPresentationModel model,
    this.navigator,
    this._getSeedsUseCase,
  ) : super(model);

  final SeedsNavigator navigator;
  final GetSeedsUseCase _getSeedsUseCase;

  SeedsPresentationModel get _model => state as SeedsPresentationModel;

  void onTapShowInfo() => navigator.openInfoSeeds();

  Future<void> loadSeeds({
    bool fromScratch = false,
  }) async {
    final cursor = fromScratch ? const Cursor.firstPage() : _model.seeds.nextPageCursor();

    await _getSeedsUseCase.execute(nextPageCursor: cursor).doOn(
          success: (seeds) {
            final newList = fromScratch ? seeds : _model.seeds + seeds;
            tryEmit(_model.copyWith(seeds: newList));
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onTapEnterCircle(Id circleId) {
    navigator.openCircleDetails(
      CircleDetailsInitialParams(
        circleId: circleId,
      ),
    );
  }

  void onSendSeeds() {
    navigator.openSellSeeds(
      SellSeedsInitialParams(
        onTransferSeedsCallback: () => loadSeeds(fromScratch: true),
      ),
    );
  }
}
