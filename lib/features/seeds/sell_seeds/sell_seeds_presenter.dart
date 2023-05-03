import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/sell_seeds/models/sell_seeds_step.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_initial_params.dart';

class SellSeedsPresenter extends Cubit<SellSeedsViewModel> {
  SellSeedsPresenter(
    SellSeedsPresentationModel model,
    this.navigator,
  ) : super(model);

  final SellSeedsNavigator navigator;

  // ignore: unused_element
  SellSeedsPresentationModel get _model => state as SellSeedsPresentationModel;

  void onChooseCircle(Seed seed) {
    tryEmit(
      _model.copyWith(step: SellSeedsStep.second),
    );
    navigator.openSellSeedsSecondStep(
      SellSeedsSecondStepInitialParams(
        seed: seed,
        onTransferSeedsCallback: _model.onTransferSeedsCallback,
      ),
    );
  }

  void onGoToFirstStep() => tryEmit(
        _model.copyWith(step: SellSeedsStep.first),
      );
}
