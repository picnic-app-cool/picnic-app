import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/invite_users_to_chat_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late InviteUsersToChatUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        chatId: const Id.empty(),
        userIds: List.empty(),
      );

      // THEN
      verify(
        () => ChatMocks.chatSettingsRepository.inviteUserToChat(
          chatId: const Id.empty(),
          userIds: List.empty(),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<InviteUsersToChatUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = InviteUsersToChatUseCase(ChatMocks.chatSettingsRepository);

    when(
      () => ChatMocks.chatSettingsRepository.inviteUserToChat(
        chatId: const Id.empty(),
        userIds: List.empty(),
      ),
    ).thenAnswer((_) => successFuture(unit));

    when(
      () => ChatMocks.inviteUsersToChatUseCase.execute(
        chatId: const Id.empty(),
        userIds: List.empty(),
      ),
    ).thenAnswer((_) {
      return successFuture(unit);
    });
  });
}
