import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/gql_generated_token.dart';
import 'package:picnic_app/core/data/graphql/pods_queries.dart';
import 'package:picnic_app/core/domain/model/generated_token.dart';
import 'package:picnic_app/core/domain/model/get_user_scoped_pod_token_failure.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GraphqlPodsRepository implements PodsRepository {
  const GraphqlPodsRepository(this._gqlClient);

  final GraphQLClient _gqlClient;

  @override
  Future<Either<GetUserScopedPodTokenFailure, GeneratedToken>> getGeneratedAppToken({
    required Id podId,
  }) =>
      _gqlClient
          .mutate(
            document: getGeneratedAppTokenMutation,
            variables: {
              'appID': podId.value,
            },
            parseData: (json) {
              final data = json['generateUserScopedAppToken'] as Map<String, dynamic>;
              return GqlGeneratedToken.fromJson(data);
            },
          )
          .mapFailure(GetUserScopedPodTokenFailure.unknown)
          .mapSuccess((response) => response.toDomain());
}
