import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/domain/model/seeds_offer.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SellSeedsSecondStepPresentationModel implements SellSeedsSecondStepViewModel {
  /// Creates the initial state
  SellSeedsSecondStepPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SellSeedsSecondStepInitialParams initialParams,
  )   : seed = initialParams.seed,
        recipient = const PublicProfile.empty(),
        onTransferSeedsCallback = initialParams.onTransferSeedsCallback,
        melonAmount = 0,
        seedAmount = 0;

  /// Used for the copyWith method
  SellSeedsSecondStepPresentationModel._({
    required this.seed,
    required this.recipient,
    required this.melonAmount,
    required this.seedAmount,
    required this.onTransferSeedsCallback,
  });

  final Seed seed;

  @override
  final PublicProfile recipient;

  final VoidCallback? onTransferSeedsCallback;

  //TODO(GS-2234): Melons : https://picnic-app.atlassian.net/browse/GS-2234
  final int melonAmount;
  final int seedAmount;

  @override
  bool get insufficientSeeds => seedAmount > seed.amountAvailable;

  @override
  bool get sendOfferEnabled => !insufficientSeeds && seedAmount > 0 && recipient != const PublicProfile.empty();

  SeedsOffer get seedsOffer => SeedsOffer(
        melonsAmount: melonAmount,
        recipientId: recipient.id,
        circleId: seed.circle.id,
        seedAmount: seedAmount,
      );

  SellSeedsSecondStepPresentationModel copyWith({
    Seed? seed,
    PublicProfile? recipient,
    int? seedAmount,
    int? melonAmount,
    VoidCallback? onTransferSeedsCallback,
  }) {
    return SellSeedsSecondStepPresentationModel._(
      seed: seed ?? this.seed,
      seedAmount: seedAmount ?? this.seedAmount,
      melonAmount: melonAmount ?? this.melonAmount,
      recipient: recipient ?? this.recipient,
      onTransferSeedsCallback: onTransferSeedsCallback ?? this.onTransferSeedsCallback,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SellSeedsSecondStepViewModel {
  bool get insufficientSeeds;

  bool get sendOfferEnabled;

  PublicProfile get recipient;
}
