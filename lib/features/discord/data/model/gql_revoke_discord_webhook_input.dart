import 'package:picnic_app/features/discord/domain/model/revoke_discord_webhook_input.dart';

extension GqlRevokeDiscordWebhookInput on RevokeDiscordWebhookInput {
  Map<String, dynamic> toJson() {
    return {
      'circleId': circleId.value,
    };
  }
}
