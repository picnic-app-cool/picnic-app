import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_settings_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late GetChatSettingsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        chatId: const Id.empty(),
      );

      // THEN
      verify(
        () => ChatMocks.chatSettingsRepository.getChatSettings(
          chatId: const Id.empty(),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetChatSettingsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetChatSettingsUseCase(ChatMocks.chatSettingsRepository);

    when(
      () => ChatMocks.chatSettingsRepository.getChatSettings(
        chatId: const Id.empty(),
      ),
    ).thenAnswer((_) => successFuture(Stubs.chatSettings));

    when(
      () => ChatMocks.getChatSettingsUseCase.execute(
        chatId: const Id.empty(),
      ),
    ).thenAnswer((_) {
      return successFuture(Stubs.chatSettings);
    });
  });
}
