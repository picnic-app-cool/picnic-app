import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class RevokeDiscordWebhookInput extends Equatable {
  const RevokeDiscordWebhookInput({
    required this.circleId,
  });

  const RevokeDiscordWebhookInput.empty() : circleId = const Id.empty();

  final Id circleId;

  @override
  List<Object?> get props => [
        circleId,
      ];

  RevokeDiscordWebhookInput copyWith({
    Id? circleId,
  }) {
    return RevokeDiscordWebhookInput(
      circleId: circleId ?? this.circleId,
    );
  }
}
