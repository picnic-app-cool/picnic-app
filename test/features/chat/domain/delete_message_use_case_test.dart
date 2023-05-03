import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/delete_message_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late DeleteMessageUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        messageId: const Id.empty(),
      );

      // THEN
      verify(
        () => ChatMocks.chatRepository.deleteMessage(
          messageId: const Id.empty(),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<DeleteMessageUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = DeleteMessageUseCase(ChatMocks.chatRepository);

    when(
      () => ChatMocks.chatRepository.deleteMessage(
        messageId: const Id.empty(),
      ),
    ).thenAnswer((_) => successFuture(unit));

    when(
      () => ChatMocks.deleteMessageUseCase.execute(
        messageId: const Id.empty(),
      ),
    ).thenAnswer((_) {
      return successFuture(unit);
    });
  });
}
