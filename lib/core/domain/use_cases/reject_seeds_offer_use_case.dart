import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/reject_seeds_offer_failure.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class RejectSeedsOfferUseCase {
  const RejectSeedsOfferUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<RejectSeedsOfferFailure, Unit>> execute({required Id offerId, required Id userId}) async {
    return _seedsRepository.rejectSellSeedsOffer(offerId: offerId, userId: userId);
  }
}
