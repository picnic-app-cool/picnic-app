import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/send_chat_message_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late SendChatMessageUseCase useCase;
  final chatMessageInput = Stubs.chatMessageInput;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(chatId: const Id.none(), message: chatMessageInput);

      // THEN
      verify(
        () => ChatMocks.chatRepository.sendChatMessage(chatId: any(named: "chatId"), message: chatMessageInput),
      );
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<SendChatMessageUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = SendChatMessageUseCase(ChatMocks.chatRepository);

    when(() => ChatMocks.chatRepository.sendChatMessage(chatId: const Id.none(), message: chatMessageInput))
        .thenAnswer((_) => successFuture(const ChatMessage.empty()));

    when(() => ChatMocks.sendChatMessageUseCase.execute(chatId: const Id.none(), message: chatMessageInput))
        .thenAnswer((_) {
      return successFuture(const ChatMessage.empty());
    });
  });
}
