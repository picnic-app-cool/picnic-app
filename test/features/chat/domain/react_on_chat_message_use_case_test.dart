import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/use_cases/react_on_chat_message_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late ReactOnChatMessageUseCase useCase;

  setUpAll(() {
    registerFallbackValue(ChatMessageReactionType.empty());
  });

  test(
    'use case witch action react executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        messageId: const Id("messageId"),
        action: ReactOnChatMessageAction.react,
        reactionType: Stubs.messageReactionType,
      );

      // THEN
      verify(
        () => ChatMocks.chatRepository.reactToMessage(
          messageId: const Id("messageId"),
          reactionType: Stubs.messageReactionType,
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    'use case witch action unreact executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        messageId: const Id("messageId"),
        action: ReactOnChatMessageAction.unreact,
        reactionType: Stubs.messageReactionType,
      );

      // THEN
      verify(
        () => ChatMocks.chatRepository.unreactToMessage(
          messageId: const Id("messageId"),
          reactionType: Stubs.messageReactionType,
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<ReactOnChatMessageUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = ReactOnChatMessageUseCase(ChatMocks.chatRepository);

    when(
      () => ChatMocks.chatRepository.reactToMessage(
        messageId: const Id("messageId"),
        reactionType: Stubs.messageReactionType,
      ),
    ).thenAnswer((_) => successFuture(Stubs.messageReaction));

    when(
      () => ChatMocks.chatRepository.unreactToMessage(
        messageId: const Id("messageId"),
        reactionType: Stubs.messageReactionType,
      ),
    ).thenAnswer((_) => successFuture(Stubs.messageReaction));

    when(
      () => ChatMocks.reactOnChatMessageUseCase.execute(
        messageId: const Id("messageId"),
        action: any(named: "action"),
        reactionType: any(named: "reactionType"),
      ),
    ).thenAnswer((_) {
      return successFuture(Stubs.messageReaction);
    });
  });
}
