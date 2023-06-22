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
    required this.discordRedirectUrl,
    required this.robloxRedirectUrl,
    required this.discordClientId,
    required this.robloxClientId,
  });

  const EnvironmentConfig.staging()
      : slug = EnvironmentConfigSlug.staging,
        baseChatUri = 'wss://api-stg.picnicgcp.net/connection/websocket',
        baseGraphQLUrl = 'https://api-stg.picnicgcp.net/query',
        baseInAppNotificationsUri = 'wss://api-stg.picnicgcp.net/notify/connection/websocket',
        discordRedirectUrl = "https://stg.picnic.zone/login",
        discordClientId = '1101435834395283506',
        robloxRedirectUrl = "https://stg.picnic.zone/robloxAuthSuccess",
        robloxClientId = '5958430914369103504';

  const EnvironmentConfig.prod()
      : slug = EnvironmentConfigSlug.production,
        baseChatUri = 'wss://api.picnicgcp.net/connection/websocket',
        baseGraphQLUrl = 'https://api.picnicgcp.net/query',
        baseInAppNotificationsUri = 'wss://api.picnicgcp.net/notify/connection/websocket',
        discordRedirectUrl = "https://picnic.zone/login",
        discordClientId = '1100738037777956954',
        robloxRedirectUrl = "https://picnic.zone/robloxAuthSuccess",
        robloxClientId = '6722474380698967025';

  final EnvironmentConfigSlug slug;
  final String baseGraphQLUrl;
  final String baseChatUri;
  final String baseInAppNotificationsUri;
  final String discordRedirectUrl;
  final String robloxRedirectUrl;
  final String discordClientId;
  final String robloxClientId;

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
