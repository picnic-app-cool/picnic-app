import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/gql_circle.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/create_circle/data/circle_creation_queries.dart';
import 'package:picnic_app/features/create_circle/data/model/gql_create_circle_input.dart';
import 'package:picnic_app/features/create_circle/domain/model/create_circle_failure.dart';
import 'package:picnic_app/features/create_circle/domain/repositories/circle_creation_repository.dart';

class GraphqlCircleCreationRepository implements CircleCreationRepository {
  const GraphqlCircleCreationRepository(
    this._gqlClient,
  );

  final GraphQLClient _gqlClient;

  @override
  Future<Either<CreateCircleFailure, Circle>> createCircle({
    required CircleInput input,
  }) {
    return _gqlClient.mutate(
      document: createCircleMutation,
      parseData: (json) {
        return GqlCircle.fromJson(json['createCircle'] as Map<String, dynamic>).toDomain();
      },
      variables: {
        'circleInput': input.toJson(),
      },

      /// This is done on purpose in GS-1406 to show name taken error only for v1
      /// This should be handled differently in the future
    ).mapFailure(CreateCircleFailure.circleNameTaken);
  }
}
