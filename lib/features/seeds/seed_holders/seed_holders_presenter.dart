import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_seed_holders_use_case.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_navigator.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_presentation_model.dart';

import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_initial_params.dart';

class SeedHoldersPresenter extends Cubit<SeedHoldersViewModel> {
  SeedHoldersPresenter(
    SeedHoldersPresentationModel model,
    this.navigator,
    this._getSeedHoldersUseCase,
  ) : super(model);

  final SeedHoldersNavigator navigator;
  final GetSeedHoldersUseCase _getSeedHoldersUseCase;

  // ignore: unused_element
  SeedHoldersPresentationModel get _model => state as SeedHoldersPresentationModel;

  void onInit() => getSeedHolders();

  void onTapApprove() => notImplemented();

  void onTapReject() => notImplemented();

  Future<void> onTapInfo() => navigator.openAboutElections(const AboutElectionsInitialParams());

  void onTapSendSeeds() => navigator.openSellSeeds(SellSeedsInitialParams(circleId: _model.circleId));

  void getSeedHolders() => _getSeedHoldersUseCase
          .execute(circleId: _model.circleId)
          .doOn(
            success: (list) => tryEmit(_model.copyWith(seedHolders: _model.seedHolders + list)),
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          )
          .observeStatusChanges(
        (result) {
          tryEmit(_model.copyWith(seedsHoldersResult: result));
        },
      );

  void onTapUser(Id id) {
    navigator.openProfile(userId: id);
  }
}
