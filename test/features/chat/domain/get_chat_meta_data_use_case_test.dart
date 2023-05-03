import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_unread_chats_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late GetUnreadChatsUseCase useCase;

  setUp(() {
    useCase = GetUnreadChatsUseCase(ChatMocks.chatRepository);

    when(
      () => ChatMocks.chatRepository.getUnreadChats(),
    ).thenAnswer((_) => successFuture(List.empty()));

    when(
      () => ChatMocks.getUnreadChatsUseCase.execute(),
    ).thenAnswer((_) => successFuture(List.empty()));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetUnreadChatsUseCase>();
    expect(useCase, isNotNull);
  });
}
