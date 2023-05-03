import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/cache_policy.dart';

/// encapsulates options you can pass to `watchQuery` in GraphQLClient to set its behavior.
class WatchQueryOptions extends Equatable {
  const WatchQueryOptions({
    required this.cachePolicy,
    required this.continueWatchingAfterNetworkResponse,
    required this.pollInterval,
  });

  const WatchQueryOptions.empty()
      : continueWatchingAfterNetworkResponse = false,
        cachePolicy = CachePolicy.noCache,
        pollInterval = Duration.zero;

  const WatchQueryOptions.defaultOptions()
      : continueWatchingAfterNetworkResponse = false,
        cachePolicy = CachePolicy.cacheAndNetwork,
        pollInterval = Duration.zero;

  /// cache policy to use when watching query
  final CachePolicy cachePolicy;

  /// determines, whether returned stream from watchQuery should finish immediately after first emission from network.
  /// setting this to `true` will keep the subscription indefinitely and emit any updates
  /// to the caching system, or, if interval specified any new responses from network at the specified interval
  final bool continueWatchingAfterNetworkResponse;

  /// when specified and non-zero, will start polling server with specified query every [pollInterval]
  final Duration pollInterval;

  @override
  List<Object> get props => [
        cachePolicy,
        continueWatchingAfterNetworkResponse,
        pollInterval,
      ];

  WatchQueryOptions copyWith({
    CachePolicy? cachePolicy,
    bool? continueWatchingAfterNetworkResponse,
    Duration? pollInterval,
  }) {
    return WatchQueryOptions(
      cachePolicy: cachePolicy ?? this.cachePolicy,
      continueWatchingAfterNetworkResponse:
          continueWatchingAfterNetworkResponse ?? this.continueWatchingAfterNetworkResponse,
      pollInterval: pollInterval ?? this.pollInterval,
    );
  }
}
