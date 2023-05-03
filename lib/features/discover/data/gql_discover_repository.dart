import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/discover/data/discover_queries.dart';
import 'package:picnic_app/features/discover/data/model/gql_circle_group.dart';
import 'package:picnic_app/features/discover/domain/model/circle_group.dart';
import 'package:picnic_app/features/discover/domain/model/discover_failure.dart';
import 'package:picnic_app/features/discover/domain/repositories/discover_repository.dart';

class GqlDiscoverRepository implements DiscoverRepository {
  GqlDiscoverRepository(this._gqlClient);

  final GraphQLClient _gqlClient;

  @override
  Future<Either<DiscoverFailure, List<CircleGroup>>> getGroups() {
    return _gqlClient
        .query(
          document: groupsQuery,
          parseData: (json) => asList(
            json,
            "feedGroups",
            (json) => GqlCircleGroup.fromJson(json),
          ),
        )
        .mapFailure(DiscoverFailure.unknown)
        .mapSuccess(
          (data) => data.map((e) => e.toDomain()).toList(growable: false),
        );
  }
}
