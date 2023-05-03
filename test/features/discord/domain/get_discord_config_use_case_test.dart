import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/discord/domain/model/discord_config_response.dart';
import 'package:picnic_app/features/discord/domain/use_cases/get_discord_config_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/discord_mocks.dart';

void main() {
  late GetDiscordConfigUseCase useCase;

  setUp(() {
    useCase = GetDiscordConfigUseCase(DiscordMocks.discordRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => DiscordMocks.discordRepository.getDiscordConfig(circleId: Stubs.circle.id))
          .thenAnswer((_) => successFuture(const DiscordConfigResponse.empty()));

      // WHEN
      final result = await useCase.execute(circleId: Stubs.circle.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetDiscordConfigUseCase>();
    expect(useCase, isNotNull);
  });
}
