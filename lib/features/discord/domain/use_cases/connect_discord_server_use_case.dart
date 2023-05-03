import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/discord/domain/model/configure_discord_webhook_input.dart';
import 'package:picnic_app/features/discord/domain/model/connect_discord_server_failure.dart';
import 'package:picnic_app/features/discord/domain/repositories/discord_repository.dart';

class ConnectDiscordServerUseCase {
  const ConnectDiscordServerUseCase(this._discordRepository);

  final DiscordRepository _discordRepository;

  Future<Either<ConnectDiscordServerFailure, Unit>> execute({
    required Id circleId,
    required String serverWebhook,
  }) async =>
      _discordRepository.connectDiscordServer(
        ConfigureDiscordWebhookInput(
          circleId: circleId,
          webhookUrl: serverWebhook,
        ),
      );
}
