import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/discord/domain/model/configure_discord_webhook_input.dart';
import 'package:picnic_app/features/discord/domain/use_cases/connect_discord_server_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/discord_mocks.dart';

void main() {
  late ConnectDiscordServerUseCase useCase;

  setUp(() {
    useCase = ConnectDiscordServerUseCase(DiscordMocks.discordRepository);
    registerFallbackValue(const ConfigureDiscordWebhookInput.empty());
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => DiscordMocks.discordRepository.connectDiscordServer(any())).thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(circleId: Stubs.circle.id, serverWebhook: '');

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<ConnectDiscordServerUseCase>();
    expect(useCase, isNotNull);
  });
}
