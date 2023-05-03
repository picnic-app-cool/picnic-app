import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';

/// Interface representing custom variable for GraphQL.
///
/// It allows to wrap common code required for GraphQL variable and reuse it.
abstract class GraphQLCustomVariable {
  Future<Either<GraphQLFailure, dynamic>> getGraphQLVariable();
}
