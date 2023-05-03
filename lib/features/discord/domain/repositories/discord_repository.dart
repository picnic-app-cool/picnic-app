import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/discord/domain/model/configure_discord_webhook_input.dart';
import 'package:picnic_app/features/discord/domain/model/connect_discord_server_failure.dart';
import 'package:picnic_app/features/discord/domain/model/discord_config_response.dart';
import 'package:picnic_app/features/discord/domain/model/get_discord_config_failure.dart';
import 'package:picnic_app/features/discord/domain/model/revoke_discord_webhook_failure.dart';
import 'package:picnic_app/features/discord/domain/model/revoke_discord_webhook_input.dart';

abstract class DiscordRepository {
  Future<Either<ConnectDiscordServerFailure, Unit>> connectDiscordServer(ConfigureDiscordWebhookInput input);

  Future<Either<RevokeDiscordWebhookFailure, Unit>> revokeWebhook(RevokeDiscordWebhookInput input);

  Future<Either<GetDiscordConfigFailure, DiscordConfigResponse>> getDiscordConfig({required Id circleId});
}
