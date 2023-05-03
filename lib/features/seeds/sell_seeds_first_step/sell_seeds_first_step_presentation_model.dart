import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SellSeedsFirstStepPresentationModel implements SellSeedsFirstStepViewModel {
  /// Creates the initial state
  SellSeedsFirstStepPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SellSeedsFirstStepInitialParams initialParams,
  )   : search = '',
        circleId = initialParams.circleId,
        seeds = const PaginatedList.empty(),
        onChooseCircle = initialParams.onChooseCircle;

  /// Used for the copyWith method
  SellSeedsFirstStepPresentationModel._({
    required this.search,
    required this.seeds,
    required this.onChooseCircle,
    required this.circleId,
  });

  @override
  final String search;

  final Id? circleId;

  @override
  final PaginatedList<Seed> seeds;

  final OnChooseCircle onChooseCircle;

  SellSeedsFirstStepPresentationModel copyWith({
    String? search,
    Id? circleId,
    PaginatedList<Seed>? seeds,
  }) {
    return SellSeedsFirstStepPresentationModel._(
      search: search ?? this.search,
      circleId: circleId ?? this.circleId,
      seeds: seeds ?? this.seeds,
      onChooseCircle: onChooseCircle,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SellSeedsFirstStepViewModel {
  String get search;

  PaginatedList<Seed> get seeds;
}
