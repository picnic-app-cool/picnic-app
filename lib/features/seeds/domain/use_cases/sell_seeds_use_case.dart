import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/seeds/domain/model/seeds_offer.dart';
import 'package:picnic_app/features/seeds/domain/model/sell_seeds_failure.dart';

class SellSeedsUseCase {
  const SellSeedsUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<SellSeedsFailure, Unit>> execute({
    required SeedsOffer seedsOffer,
  }) =>
      _seedsRepository.sellSeeds(
        seedsOffer: seedsOffer,
      );
}
