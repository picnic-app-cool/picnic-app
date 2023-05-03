import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_members_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late GetChatMembersUseCase useCase;

  setUp(() {
    useCase = GetChatMembersUseCase(ChatMocks.chatRepository);

    when(
      () => ChatMocks.chatRepository.getChatMembers(
        chatId: const Id.empty(),
        nextPageCursor: const Cursor.empty(),
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.singlePage()));

    when(
      () => ChatMocks.getChatMembersUseCase.execute(
        chatId: const Id.empty(),
        nextPageCursor: const Cursor.empty(),
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.singlePage()));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        chatId: const Id.empty(),
        nextPageCursor: const Cursor.empty(),
      );

      // THEN
      verify(
        () => ChatMocks.chatRepository.getChatMembers(
          chatId: const Id.empty(),
          nextPageCursor: const Cursor.empty(),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetChatMembersUseCase>();
    expect(useCase, isNotNull);
  });
}
