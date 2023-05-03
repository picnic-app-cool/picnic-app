import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/accept_seeds_offer_failure.dart';
import 'package:picnic_app/core/domain/model/cancel_seeds_offer_failure.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/reject_seeds_offer_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/election.dart';
import 'package:picnic_app/features/seeds/domain/model/election_candidate.dart';
import 'package:picnic_app/features/seeds/domain/model/get_election_candidates_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/get_election_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/get_seedholders_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/get_seeds_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/get_user_seeds_total_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/domain/model/seed_holder.dart';
import 'package:picnic_app/features/seeds/domain/model/seeds_offer.dart';
import 'package:picnic_app/features/seeds/domain/model/sell_seeds_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/transfer_seeds_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_director_failure.dart';

abstract class SeedsRepository {
  Future<Either<SellSeedsFailure, Unit>> sellSeeds({
    required SeedsOffer seedsOffer,
  });

  Future<Either<TransferSeedsFailure, Unit>> transferSeeds({
    required SeedsOffer seedsOffer,
  });

  Future<Either<GetSeedsFailure, PaginatedList<Seed>>> getSeeds({
    String searchQuery,
    required Cursor nextPageCursor,
  });

  Future<Either<GetUserSeedsTotalFailure, int>> getUserSeedsTotal();

  Future<Either<GetSeedHoldersFailure, PaginatedList<SeedHolder>>> getSeedHolders({required Id circleId});

  Future<Either<AcceptSeedsOfferFailure, Unit>> acceptSeedsOffer({required Id offerId, required Id userId});

  Future<Either<GetElectionFailure, Election>> getElection({required Id circleId});

  Future<Either<GetElectionCandidatesFailure, PaginatedList<ElectionCandidate>>> getElectionCandidates({
    required Id circleId,
    required Cursor nextPageCursor,
  });

  Future<Either<CancelSeedsOfferFailure, Unit>> cancelSeedsOffer({required Id offerId, required Id userId});

  Future<Either<VoteDirectorFailure, Id>> voteDirector({required Id electionId, required Id userId});

  Future<Either<RejectSeedsOfferFailure, Unit>> rejectSellSeedsOffer({required Id offerId, required Id userId});
}
