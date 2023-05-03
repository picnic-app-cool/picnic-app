import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_single_chat_message_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late GetSingleChatMessageUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        chatId: const Id.empty(),
        messageId: const Id.empty(),
      );

      // THEN
      verify(
        () => ChatMocks.chatRepository.getSingleChatMessage(
          chatId: const Id.empty(),
          messageId: const Id.empty(),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetSingleChatMessageUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetSingleChatMessageUseCase(ChatMocks.chatRepository);

    when(
      () => ChatMocks.chatRepository.getSingleChatMessage(
        chatId: const Id.empty(),
        messageId: const Id.empty(),
      ),
    ).thenAnswer((_) => successFuture(Stubs.chatMessage));

    when(
      () => ChatMocks.getSingleChatMessageUseCase.execute(
        chatId: const Id.empty(),
        messageId: const Id.empty(),
      ),
    ).thenAnswer((_) {
      return successFuture(Stubs.chatMessage);
    });
  });
}
