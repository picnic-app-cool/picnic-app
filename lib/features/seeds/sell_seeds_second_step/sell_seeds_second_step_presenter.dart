import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/sell_seeds_use_case.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/transfer_seeds_use_case.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_presentation_model.dart';

class SellSeedsSecondStepPresenter extends Cubit<SellSeedsSecondStepViewModel> {
  SellSeedsSecondStepPresenter(
    SellSeedsSecondStepPresentationModel model,
    this.navigator,
    this._sellSeedsUseCase,
    this._transferSeedsUseCase,
  ) : super(model);

  final SellSeedsNavigator navigator;

  //TODO(GS-2234): Seeds and Melons : https://picnic-app.atlassian.net/browse/GS-2234
  final SellSeedsUseCase _sellSeedsUseCase;
  final TransferSeedsUseCase _transferSeedsUseCase;

  // ignore: unused_element
  SellSeedsSecondStepPresentationModel get _model => state as SellSeedsSecondStepPresentationModel;

  void onChangedMelonAmount(int value) => tryEmit(
        _model.copyWith(
          melonAmount: value,
        ),
      );

  void onChangedSeedAmount(int value) => tryEmit(
        _model.copyWith(
          seedAmount: value,
        ),
      );

  //TODO(GS-2234): Seeds and Melons : https://picnic-app.atlassian.net/browse/GS-2234
  void onTapSendOffer() {
    _sellSeedsUseCase
        .execute(
          seedsOffer: _model.seedsOffer,
        ) //
        .doOn(success: (user) => navigator.close())
        .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));
  }

  Future<void> onTapShowCircleMembers() async {
    var recipient = await navigator.openRecipients(SeedRecipientsInitialParams(circleId: _model.seed.circleId));

    if (recipient != null) {
      tryEmit(
        _model.copyWith(
          recipient: recipient,
        ),
      );
    }
  }

  Future<void> onTapConfirmTransfer() async {
    final transferConfirmed = await navigator.showConfirmSendSeedsRoute(
          recipient: _model.recipient,
          circleName: _model.seed.circleName,
          seedAmount: _model.seedAmount,
        ) ??
        false;

    if (transferConfirmed) {
      _onTapSendTransfer();
    }
  }

  void _onTapSendTransfer() {
    _transferSeedsUseCase
        .execute(
          seedsOffer: _model.seedsOffer,
        )
        .doOn(
          fail: (fail) => navigator.showError(
            fail.displayableFailure(),
          ),
          success: (user) {
            _model.onTransferSeedsCallback?.call();

            navigator.close();
          },
        );
  }
}
