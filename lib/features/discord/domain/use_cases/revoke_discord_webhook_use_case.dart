import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/discord/domain/model/revoke_discord_webhook_failure.dart';
import 'package:picnic_app/features/discord/domain/model/revoke_discord_webhook_input.dart';
import 'package:picnic_app/features/discord/domain/repositories/discord_repository.dart';

class RevokeDiscordWebhookUseCase {
  const RevokeDiscordWebhookUseCase(this._discordRepository);

  final DiscordRepository _discordRepository;

  Future<Either<RevokeDiscordWebhookFailure, Unit>> execute({
    required Id circleId,
  }) async =>
      _discordRepository.revokeWebhook(
        RevokeDiscordWebhookInput(
          circleId: circleId,
        ),
      );
}
