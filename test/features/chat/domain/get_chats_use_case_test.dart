import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chats_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late GetChatsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(nextPageCursor: const Cursor.empty());

      // THEN

      // THEN
      verify(() => ChatMocks.chatRepository.getChats(nextPageCursor: const Cursor.empty()));
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetChatsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetChatsUseCase(ChatMocks.chatRepository);

    when(() => ChatMocks.chatRepository.getChats(nextPageCursor: any(named: 'nextPageCursor')))
        .thenAnswer((_) => successFuture(const PaginatedList.empty()));

    when(() => ChatMocks.getChatsUseCase.execute(nextPageCursor: any(named: 'nextPageCursor'))).thenAnswer((_) {
      return successFuture(const PaginatedList.empty());
    });
  });
}
