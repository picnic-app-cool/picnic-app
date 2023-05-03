import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/discord/domain/model/discord_config_response.dart';
import 'package:picnic_app/features/discord/domain/model/get_discord_config_failure.dart';
import 'package:picnic_app/features/discord/domain/repositories/discord_repository.dart';

class GetDiscordConfigUseCase {
  const GetDiscordConfigUseCase(this._discordRepository);

  final DiscordRepository _discordRepository;

  Future<Either<GetDiscordConfigFailure, DiscordConfigResponse>> execute({
    required Id circleId,
  }) async =>
      _discordRepository.getDiscordConfig(circleId: circleId);
}
