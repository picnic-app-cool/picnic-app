import 'package:picnic_app/core/data/graphql/graphql_client_factory.dart';
import 'package:picnic_app/core/domain/repositories/cache_management_repository.dart';

class GraphqlCacheManagementRepository implements CacheManagementRepository {
  const GraphqlCacheManagementRepository(
    this._graphqlClientFactory,
  );

  final GraphqlClientFactory _graphqlClientFactory;

  @override
  Future<void> cleanCache() async {
    final client = await _graphqlClientFactory.createClient();
    client.cache.store.reset();
  }
}
