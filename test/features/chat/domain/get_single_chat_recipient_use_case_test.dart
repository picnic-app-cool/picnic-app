import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_single_chat_recipient_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late GetSingleChatRecipientUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        chatId: const Id.empty(),
      );

      // THEN
      verify(
        () => ChatMocks.getChatParticipantsUseCase.execute(
          chatId: const Id.empty(),
          nextPageCursor: const Cursor.empty(),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetSingleChatRecipientUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetSingleChatRecipientUseCase(ChatMocks.getChatParticipantsUseCase, Mocks.userStore);

    when(
      () => ChatMocks.getChatParticipantsUseCase.execute(
        chatId: const Id.empty(),
        nextPageCursor: const Cursor.empty(),
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.empty()));

    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
  });
}
