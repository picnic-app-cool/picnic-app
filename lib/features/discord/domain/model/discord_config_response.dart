import 'package:equatable/equatable.dart';

class DiscordConfigResponse extends Equatable {
  const DiscordConfigResponse({
    required this.webhookConfigured,
  });

  const DiscordConfigResponse.empty() : webhookConfigured = false;

  final bool webhookConfigured;

  @override
  List<Object?> get props => [
        webhookConfigured,
      ];

  DiscordConfigResponse copyWith({
    bool? webhookConfigured,
  }) {
    return DiscordConfigResponse(
      webhookConfigured: webhookConfigured ?? this.webhookConfigured,
    );
  }
}
