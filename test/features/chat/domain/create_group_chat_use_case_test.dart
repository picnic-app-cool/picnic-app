import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/create_group_chat_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late CreateGroupChatUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        name: 'New group chat',
        userIds: [const Id("1"), const Id("2"), const Id("3")],
      );

      // THEN
      verify(
        () => ChatMocks.chatRepository.createGroupChat(
          name: 'New group chat',
          userIds: [const Id("1"), const Id("2"), const Id("3")],
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<CreateGroupChatUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = CreateGroupChatUseCase(ChatMocks.chatRepository);

    when(
      () => ChatMocks.chatRepository.createGroupChat(
        name: 'New group chat',
        userIds: [const Id("1"), const Id("2"), const Id("3")],
      ),
    ).thenAnswer((_) => successFuture(Stubs.basicChat));

    when(
      () => ChatMocks.createGroupChatUseCase.execute(
        name: 'New group chat',
        userIds: [const Id("1"), const Id("2"), const Id("3")],
      ),
    ).thenAnswer((_) {
      return successFuture(Stubs.basicChat);
    });
  });
}
