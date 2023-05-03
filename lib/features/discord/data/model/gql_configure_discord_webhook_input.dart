import 'package:picnic_app/features/discord/domain/model/configure_discord_webhook_input.dart';

extension GqlConfigureDiscordWebhookInput on ConfigureDiscordWebhookInput {
  Map<String, dynamic> toJson() {
    return {
      'circleId': circleId.value,
      'webhookUrl': webhookUrl,
    };
  }
}
