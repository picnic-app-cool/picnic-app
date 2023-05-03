import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:picnic_app/core/environment_config/environment_config_slug.dart';

class EnvironmentConfig extends Equatable {
  @visibleForTesting
  const EnvironmentConfig({
    required this.slug,
    required this.baseGraphQLUrl,
    required this.baseChatUri,
    required this.baseInAppNotificationsUri,
  });

  const EnvironmentConfig.staging()
      : slug = EnvironmentConfigSlug.staging,
        baseChatUri = 'wss://api-stg.picnicgcp.net/connection/websocket',
        baseGraphQLUrl = 'https://api-stg.picnicgcp.net/query',
        baseInAppNotificationsUri = 'wss://api-stg.picnicgcp.net/notify/connection/websocket';

  const EnvironmentConfig.prod()
      : slug = EnvironmentConfigSlug.production,
        baseChatUri = 'wss://api.picnicgcp.net/connection/websocket',
        baseGraphQLUrl = 'https://api.picnicgcp.net/query',
        baseInAppNotificationsUri = 'wss://api.picnicgcp.net/notify/connection/websocket';

  final EnvironmentConfigSlug slug;
  final String baseGraphQLUrl;
  final String baseChatUri;
  final String baseInAppNotificationsUri;

  @override
  List<Object> get props => [
        slug,
        baseChatUri,
        baseGraphQLUrl,
      ];

  static EnvironmentConfig? fromString(String? slug) {
    switch (EnvironmentConfigSlug.fromString(slug)) {
      case EnvironmentConfigSlug.staging:
        return const EnvironmentConfig.staging();
      case EnvironmentConfigSlug.production:
        return const EnvironmentConfig.prod();
      case null:
        return null;
    }
  }
}
