import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/add_user_to_chat_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late AddUserToChatUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        chatId: const Id.empty(),
        userId: const Id.empty(),
      );

      // THEN
      verify(
        () => ChatMocks.chatSettingsRepository.addUserToChat(
          chatId: const Id.empty(),
          userId: const Id.empty(),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<AddUserToChatUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = AddUserToChatUseCase(ChatMocks.chatSettingsRepository);

    when(
      () => ChatMocks.chatSettingsRepository.addUserToChat(
        chatId: const Id.empty(),
        userId: const Id.empty(),
      ),
    ).thenAnswer((_) => successFuture(unit));

    when(
      () => ChatMocks.addUserToChatUseCase.execute(
        chatId: const Id.empty(),
        userId: const Id.empty(),
      ),
    ).thenAnswer((_) {
      return successFuture(unit);
    });
  });
}
