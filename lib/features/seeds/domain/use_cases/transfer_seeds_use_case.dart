import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/seeds/domain/model/seeds_offer.dart';
import 'package:picnic_app/features/seeds/domain/model/transfer_seeds_failure.dart';

class TransferSeedsUseCase {
  const TransferSeedsUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<TransferSeedsFailure, Unit>> execute({
    required SeedsOffer seedsOffer,
  }) =>
      _seedsRepository.transferSeeds(
        seedsOffer: seedsOffer,
      );
}
