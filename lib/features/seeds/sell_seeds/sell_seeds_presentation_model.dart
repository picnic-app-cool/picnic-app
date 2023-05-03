import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/sell_seeds/models/sell_seeds_step.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SellSeedsPresentationModel implements SellSeedsViewModel {
  /// Creates the initial state
  SellSeedsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SellSeedsInitialParams initialParams,
  )   : step = SellSeedsStep.first,
        circleId = initialParams.circleId,
        onTransferSeedsCallback = initialParams.onTransferSeedsCallback;

  /// Used for the copyWith method
  SellSeedsPresentationModel._({
    required this.step,
    required this.circleId,
    required this.onTransferSeedsCallback,
  });

  @override
  final SellSeedsStep step;

  @override
  final Id? circleId;

  final VoidCallback? onTransferSeedsCallback;

  @override
  int get sellSeedsStep => step.index + 1;

  SellSeedsPresentationModel copyWith({
    SellSeedsStep? step,
    Id? circleId,
    VoidCallback? onTransferSeedsCallback,
  }) {
    return SellSeedsPresentationModel._(
      step: step ?? this.step,
      circleId: circleId ?? this.circleId,
      onTransferSeedsCallback: onTransferSeedsCallback ?? this.onTransferSeedsCallback,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SellSeedsViewModel {
  SellSeedsStep get step;

  int get sellSeedsStep;

  Id? get circleId;
}
