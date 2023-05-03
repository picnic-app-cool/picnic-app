import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/leave_chat_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late LeaveChatUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN
      const id = Id.empty();
      // WHEN
      final result = await useCase.execute(chatId: id);
      // THEN
      verify(() => ChatMocks.chatRepository.leaveChat(chatId: id));
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<LeaveChatUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = LeaveChatUseCase(ChatMocks.chatRepository);
    const id = Id.empty();
    when(
      () => ChatMocks.chatRepository.leaveChat(
        chatId: id,
      ),
    ).thenAnswer((_) => successFuture(unit));
  });
}
