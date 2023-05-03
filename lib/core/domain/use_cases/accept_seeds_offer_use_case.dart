import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/accept_seeds_offer_failure.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class AcceptSeedsOfferUseCase {
  const AcceptSeedsOfferUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<AcceptSeedsOfferFailure, Unit>> execute({required Id offerId, required Id userId}) async {
    return _seedsRepository.acceptSeedsOffer(offerId: offerId, userId: userId);
  }
}
