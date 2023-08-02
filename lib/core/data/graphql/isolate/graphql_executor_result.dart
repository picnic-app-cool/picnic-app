import 'package:graphql/client.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure.dart';
import 'package:picnic_app/core/data/graphql/model/graphql_response.dart';
import 'package:picnic_app/core/domain/model/cacheable_result.dart';

class GraphQLExecutorResult<T> {
  const GraphQLExecutorResult({
    required this.cacheableResult,
    this.response,
  });

  final CacheableResult<GraphQLFailure, T> cacheableResult;
  final QueryResult<GraphQlResponse>? response;
}

extension GraphQLExecutorResultToFuture<T> on Stream<GraphQLExecutorResult<T>> {
  Future<GraphQLExecutorResult<T>> get networkResult async {
    final cacheable = await firstWhere((element) {
      return element.cacheableResult.source == CacheableSource.network;
    });
    return cacheable;
  }
}
