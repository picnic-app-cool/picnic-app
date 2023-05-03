import 'package:graphql/client.dart' as gql;
import 'package:picnic_app/core/domain/model/cache_policy.dart';
import 'package:picnic_app/core/domain/model/cacheable_result.dart';

//ignore: prefer-match-file-name
extension GqlCachePolicyExtensions on gql.FetchPolicy {
  static gql.FetchPolicy fromCachePolicy(CachePolicy policy) {
    switch (policy) {
      case CachePolicy.noCache:
        return gql.FetchPolicy.noCache;
      case CachePolicy.networkOnly:
        return gql.FetchPolicy.networkOnly;
      case CachePolicy.cacheOnly:
        return gql.FetchPolicy.cacheOnly;
      case CachePolicy.cacheFirst:
        return gql.FetchPolicy.cacheFirst;
      case CachePolicy.cacheAndNetwork:
        return gql.FetchPolicy.cacheAndNetwork;
    }
  }
}

extension QueryResultSourceExtensions on gql.QueryResultSource {
  CacheableSource toCacheableSource() {
    switch (this) {
      case gql.QueryResultSource.loading:
        return CacheableSource.cache;
      case gql.QueryResultSource.cache:
        return CacheableSource.cache;
      case gql.QueryResultSource.optimisticResult:
        return CacheableSource.cache;
      case gql.QueryResultSource.network:
        return CacheableSource.network;
    }
  }
}
