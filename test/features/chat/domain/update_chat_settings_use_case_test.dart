import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/update_chat_settings_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late UpdateChatSettingsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        chatId: const Id.empty(),
        chatSettings: Stubs.chatSettings,
      );

      // THEN
      verify(
        () => ChatMocks.chatSettingsRepository.updateChatSettings(
          chatId: const Id.empty(),
          settings: Stubs.chatSettings,
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdateChatSettingsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = UpdateChatSettingsUseCase(ChatMocks.chatSettingsRepository);

    when(
      () => ChatMocks.chatSettingsRepository.updateChatSettings(
        chatId: any(named: "chatId"),
        settings: Stubs.chatSettings,
      ),
    ).thenAnswer((_) => successFuture(unit));

    when(
      () => ChatMocks.updateChatSettingsUseCase.execute(
        chatId: any(named: "chatId"),
        chatSettings: Stubs.chatSettings,
      ),
    ).thenAnswer((_) => successFuture(unit));
  });
}
