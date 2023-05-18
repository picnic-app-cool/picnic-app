import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/data/graphql/model/gql_governance.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/data/graphql/model/gql_vote_candidate.dart';
import 'package:picnic_app/core/data/graphql/model/seed/gql_seed.dart';
import 'package:picnic_app/core/data/graphql/model/seed/gql_seed_holder.dart';
import 'package:picnic_app/core/data/graphql/seeds_queries.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/accept_seeds_offer_failure.dart';
import 'package:picnic_app/core/domain/model/cancel_seeds_offer_failure.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/reject_seeds_offer_failure.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/get_election_candidates_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/get_election_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/get_seedholders_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/get_seeds_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/get_user_seeds_total_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/governance.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/domain/model/seed_holder.dart';
import 'package:picnic_app/features/seeds/domain/model/seeds_offer.dart';
import 'package:picnic_app/features/seeds/domain/model/sell_seeds_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/transfer_seeds_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_director_failure.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

//ignore_for_file: no-magic-number
class GraphqlSeedsRepository with FutureRetarder implements SeedsRepository {
  const GraphqlSeedsRepository(
    this._gqlClient,
    this._userStore,
  );

  final GraphQLClient _gqlClient;
  final UserStore _userStore;

  @override
  Future<Either<SellSeedsFailure, Unit>> sellSeeds({
    required SeedsOffer seedsOffer,
  }) =>
      _gqlClient
          .mutate(
            document: sendExchangeOffer,
            variables: {
              'melonsAmount': seedsOffer.melonsAmount,
              'seedsAmount': seedsOffer.seedAmount,
              'circleId': seedsOffer.circleId.value,
              'recipientId': seedsOffer.circleId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['sendExchangeOffer'] as Map<String, dynamic>),
          )
          .mapFailure((fail) => const SellSeedsFailure.unknown())
          .mapSuccessPayload(onFailureReturn: const SellSeedsFailure.unknown());

  //TODO: (search query) https://picnic-app.atlassian.net/browse/GS-6875 - add query parameter to document
  @override
  Future<Either<GetSeedsFailure, PaginatedList<Seed>>> getSeeds({
    required Cursor nextPageCursor,
    String searchQuery = '',
  }) =>
      _gqlClient
          .query(
            document: getPrivateProfileSeeds,
            variables: {
              'searchQuery': searchQuery,
              'cursor': nextPageCursor.toGqlCursorInput(),
            },
            parseData: (json) {
              final data = asT<Map<String, dynamic>>(asT<Map<String, dynamic>>(json, 'myProfile'), 'seeds');
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure((fail) => GetSeedsFailure.unknown(fail))
          .mapSuccess(
            (response) => response.toDomain(nodeMapper: (json) => GqlSeed.fromJson(json).toDomain()),
          );

  @override
  Future<Either<GetUserSeedsTotalFailure, int>> getUserSeedsTotal() => _gqlClient
      .query(
        document: getPrivateProfileTotalSeeds,
        parseData: (json) {
          final data = asT<Map<String, dynamic>>(
            asT<Map<String, dynamic>>(json, 'myProfile'),
            'seeds',
          );
          return asT<int>(data, 'totalSeedsAmount');
        },
      )
      .mapFailure((fail) => GetUserSeedsTotalFailure.unknown(fail))
      .mapSuccess(
        (response) => response,
      );

  @override
  Future<Either<AcceptSeedsOfferFailure, Unit>> acceptSeedsOffer({required Id offerId, required Id userId}) =>
      _gqlClient
          .query(
            document: acceptExchangeOffer,
            variables: {
              'offerId': offerId.value,
              'userId': userId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['acceptExchangeOffer'] as Map<String, dynamic>),
          )
          .mapFailure((fail) => AcceptSeedsOfferFailure.unknown(fail))
          .mapSuccessPayload(onFailureReturn: const AcceptSeedsOfferFailure.unknown());

  @override
  Future<Either<VoteDirectorFailure, Id>> voteDirector({
    required Id circleId,
    required Id userId,
  }) =>
      _gqlClient
          .mutate(
            document: voteForDirectorMutation,
            variables: {
              'circleId': circleId.value,
              'userId': userId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['voteForDirector'] as Map<String, dynamic>),
          )
          .mapFailure(VoteDirectorFailure.unknown)
          .mapSuccess((response) => userId);

  @override
  Future<Either<GetElectionCandidatesFailure, PaginatedList<VoteCandidate>>> getCandidatesThatCanBeVoted({
    required Id circleId,
    required Cursor nextPageCursor,
    required String searchQuery,
  }) =>
      _gqlClient
          .query(
            document: searchVoteCandidatesQuery,
            variables: {
              'circleId': circleId.value,
              'cursor': nextPageCursor.toGqlCursorInput(),
              'search': searchQuery,
            },
            parseData: (json) {
              final data = json['searchVoteCandidates'] as Map<String, dynamic>;
              return GqlConnection.fromJson(data);
            },
          )
          .mapFailure(GetElectionCandidatesFailure.unknown)
          .mapSuccess(
            (connection) => connection.toDomain(
              nodeMapper: (node) => GqlVoteCandidate.fromJson(node).toDomain(_userStore),
            ),
          );

  @override
  Future<Either<CancelSeedsOfferFailure, Unit>> cancelSeedsOffer({required Id offerId, required Id userId}) =>
      _gqlClient
          .mutate(
            document: cancelExchangeOffer,
            variables: {
              'offerId': offerId.value,
              'userId': userId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['rejectExchangeOffer'] as Map<String, dynamic>),
          )
          .mapFailure(CancelSeedsOfferFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const CancelSeedsOfferFailure.unknown());

  @override
  Future<Either<GetElectionFailure, Governance>> getGovernance({required Id circleId}) => _gqlClient
      .query(
        document: getGovernanceQuery,
        variables: {
          'circleId': circleId.value,
        },
        parseData: (json) {
          return GqlGovernance.fromJson(asT(json, 'getGovernance'));
        },
      )
      .mapFailure(GetElectionFailure.unknown)
      .mapSuccess(
        (response) => response.toDomain(_userStore),
      );

  @override
  Future<Either<RejectSeedsOfferFailure, Unit>> rejectSellSeedsOffer({required Id offerId, required Id userId}) =>
      _gqlClient
          .mutate(
            document: rejectExchangeOffer,
            variables: {
              'offerId': offerId.value,
              'userId': userId.value,
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['cancelOffer'] as Map<String, dynamic>),
          )
          .mapFailure(RejectSeedsOfferFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const RejectSeedsOfferFailure.unknown());

  @override
  Future<Either<GetSeedHoldersFailure, PaginatedList<SeedHolder>>> getSeedHolders({required Id circleId}) => _gqlClient
      .query(
        document: circleSeedsConnection,
        variables: {
          'circleId': circleId.value,
        },
        parseData: (json) {
          final data = asT<Map<String, dynamic>>(asT<Map<String, dynamic>>(json, 'getCircleById'), 'seedsConnection');
          return GqlConnection.fromJson(data);
        },
      )
      .mapFailure((fail) => GetSeedHoldersFailure.unknown(fail))
      .mapSuccess(
        (response) => response.toDomain(
          nodeMapper: (json) => GqlSeedHolder.fromJson(json).toDomain(
            _userStore,
          ),
        ),
      );

  @override
  Future<Either<TransferSeedsFailure, Unit>> transferSeeds({required SeedsOffer seedsOffer}) => _gqlClient
      .mutate(
        document: transferSeedsMutation,
        variables: {
          'seedsAmount': seedsOffer.seedAmount,
          'circleId': seedsOffer.circleId.value,
          'recipientId': seedsOffer.recipientId.value,
        },
        parseData: (json) => GqlSuccessPayload.fromJson(json['transferSeeds'] as Map<String, dynamic>),
      )
      .mapFailure((fail) => const TransferSeedsFailure.unknown())
      .mapSuccessPayload(onFailureReturn: const TransferSeedsFailure.unknown());
}
