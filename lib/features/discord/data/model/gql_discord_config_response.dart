import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/discord/domain/model/discord_config_response.dart';

class GqlDiscordConfigResponse {
  const GqlDiscordConfigResponse({
    required this.webhookConfigured,
  });

  factory GqlDiscordConfigResponse.fromJson(Map<String, dynamic>? json) => GqlDiscordConfigResponse(
        webhookConfigured: asT<bool>(json, 'webhookConfigured'),
      );

  final bool webhookConfigured;

  DiscordConfigResponse toDomain() => DiscordConfigResponse(
        webhookConfigured: webhookConfigured,
      );
}
