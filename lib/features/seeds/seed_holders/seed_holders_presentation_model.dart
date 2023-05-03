import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/future_result.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/get_seedholders_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/seed_holder.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SeedHoldersPresentationModel implements SeedHoldersViewModel {
  /// Creates the initial state
  SeedHoldersPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SeedHoldersInitialParams initialParams,
    this.currentTimeProvider,
  )   : seedHolders = const PaginatedList.empty(),
        isSeedHolder = initialParams.isSeedHolder,
        seedsHoldersResult = const FutureResult.empty(),
        circleId = initialParams.circleId,
        deadline = currentTimeProvider.currentTime.add(const Duration(minutes: 5));

  /// Used for the copyWith method
  SeedHoldersPresentationModel._({
    required this.seedHolders,
    required this.currentTimeProvider,
    required this.deadline,
    required this.circleId,
    required this.isSeedHolder,
    required this.seedsHoldersResult,
  });

  @override
  final PaginatedList<SeedHolder> seedHolders;

  final FutureResult<Either<GetSeedHoldersFailure, PaginatedList<SeedHolder>>> seedsHoldersResult;

  @override
  final CurrentTimeProvider currentTimeProvider;

  @override
  final DateTime deadline;

  final Id circleId;

  @override
  final bool isSeedHolder;

  @override
  bool get isLoading => seedsHoldersResult.isPending();

  //TODO: remove once BE integrated : https://picnic-app.atlassian.net/browse/GS-6903
  @override
  int get seedCount => seedHolders.items.fold(0, (previousValue, seedHolder) => previousValue + seedHolder.amountTotal);

  SeedHoldersPresentationModel copyWith({
    PaginatedList<SeedHolder>? seedHolders,
    CurrentTimeProvider? currentTimeProvider,
    DateTime? deadline,
    Id? circleId,
    bool? isSeedHolder,
    FutureResult<Either<GetSeedHoldersFailure, PaginatedList<SeedHolder>>>? seedsHoldersResult,
  }) {
    return SeedHoldersPresentationModel._(
      seedHolders: seedHolders ?? this.seedHolders,
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      deadline: deadline ?? this.deadline,
      circleId: circleId ?? this.circleId,
      isSeedHolder: isSeedHolder ?? this.isSeedHolder,
      seedsHoldersResult: seedsHoldersResult ?? this.seedsHoldersResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SeedHoldersViewModel {
  PaginatedList<SeedHolder> get seedHolders;

  int get seedCount;

  CurrentTimeProvider get currentTimeProvider;

  DateTime get deadline;

  bool get isSeedHolder;

  bool get isLoading;
}
