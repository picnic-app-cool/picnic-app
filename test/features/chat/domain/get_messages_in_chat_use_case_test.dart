import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_messages_in_chat_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late GetMessagesInChatUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        nextPageCursor: const Cursor.empty(),
        chatId: const Id.empty(),
      );

      // THEN
      verify(
        () => ChatMocks.chatRepository.getMessagesInChat(
          nextPageCursor: const Cursor.empty(),
          chatId: const Id.empty(),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetMessagesInChatUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetMessagesInChatUseCase(
      ChatMocks.chatRepository,
    );

    when(
      () => ChatMocks.chatRepository.getMessagesInChat(
        nextPageCursor: const Cursor.empty(),
        chatId: const Id.empty(),
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.empty()));

    when(
      () => ChatMocks.getMessagesInChatUseCase.execute(
        nextPageCursor: const Cursor.empty(),
        chatId: const Id.empty(),
      ),
    ).thenAnswer((_) {
      return successFuture(const PaginatedList.empty());
    });
  });
}
