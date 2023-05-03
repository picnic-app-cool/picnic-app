import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_feeds_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chats_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late GetChatFeedsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => ChatMocks.chatRepository.getChatFeeds(nextPageCursor: any(named: 'nextPageCursor')))
          .thenAnswer((_) => successFuture(const PaginatedList.singlePage()));

      // WHEN
      final result = await useCase.execute(nextPageCursor: const Cursor.empty());

      // THEN
      verify(() => ChatMocks.chatRepository.getChatFeeds(nextPageCursor: const Cursor.empty()));
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetChatsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetChatFeedsUseCase(ChatMocks.chatRepository);
  });
}
