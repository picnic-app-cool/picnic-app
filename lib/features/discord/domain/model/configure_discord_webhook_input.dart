import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ConfigureDiscordWebhookInput extends Equatable {
  const ConfigureDiscordWebhookInput({
    required this.circleId,
    required this.webhookUrl,
  });

  const ConfigureDiscordWebhookInput.empty()
      : circleId = const Id.empty(),
        webhookUrl = '';

  final Id circleId;
  final String webhookUrl;

  @override
  List<Object?> get props => [
        circleId,
        webhookUrl,
      ];

  ConfigureDiscordWebhookInput copyWith({
    Id? circleId,
    String? webhookUrl,
  }) {
    return ConfigureDiscordWebhookInput(
      circleId: circleId ?? this.circleId,
      webhookUrl: webhookUrl ?? this.webhookUrl,
    );
  }
}
