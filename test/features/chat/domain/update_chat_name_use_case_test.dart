import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/update_chat_name_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late UpdateChatNameUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        chatId: const Id.empty(),
        name: "name",
      );

      // THEN
      verify(
        () => ChatMocks.chatSettingsRepository.updateChatName(
          chatId: const Id.empty(),
          name: "name",
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdateChatNameUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = UpdateChatNameUseCase(ChatMocks.chatSettingsRepository);

    when(
      () => ChatMocks.chatSettingsRepository.updateChatName(
        chatId: any(named: "chatId"),
        name: any(named: "name"),
      ),
    ).thenAnswer((_) => successFuture(unit));

    when(
      () => ChatMocks.updateChatNameUseCase.execute(
        chatId: any(named: "chatId"),
        name: any(named: "name"),
      ),
    ).thenAnswer((_) => successFuture(unit));
  });
}
