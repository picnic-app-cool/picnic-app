import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cancel_seeds_offer_failure.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class CancelSeedsOfferUseCase {
  const CancelSeedsOfferUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<CancelSeedsOfferFailure, Unit>> execute({required Id offerId, required Id userId}) =>
      _seedsRepository.cancelSeedsOffer(offerId: offerId, userId: userId);
}
