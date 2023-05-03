import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/create_slice/data/model/gql_create_slice_input.dart';
import 'package:picnic_app/features/create_slice/data/model/gql_slice.dart';
import 'package:picnic_app/features/create_slice/data/model/slice_creation_queries.dart';
import 'package:picnic_app/features/create_slice/domain/model/create_slice_failure.dart';
import 'package:picnic_app/features/create_slice/domain/model/slice_input.dart';
import 'package:picnic_app/features/create_slice/domain/repositories/slice_creation_repository.dart';

class GraphqlSliceCreationRepository implements SliceCreationRepository {
  const GraphqlSliceCreationRepository(
    this._gqlClient,
  );

  final GraphQLClient _gqlClient;

  @override
  Future<Either<CreateSliceFailure, Slice>> createSlice({
    required SliceInput input,
  }) {
    return _gqlClient.mutate(
      document: createSliceMutation,
      parseData: (json) {
        return GqlSlice.fromJson(json['createSlice'] as Map<String, dynamic>).toDomain();
      },
      variables: {
        'createSliceInput': input.toJson(),
      },
    ).mapFailure(CreateSliceFailure.unknown);
  }
}
