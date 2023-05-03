import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_action.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_failure.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/use_cases/chat_messages_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_live_data_client.dart';
import '../../../test_utils/test_utils.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late ChatMessagesUseCase useCase;

  late final messageFirst = Stubs.chatMessage.copyWith(id: const Id("message_first"));
  late final messageSecond = Stubs.chatMessage.copyWith(id: const Id("message_second"));
  late final messageThird = Stubs.chatMessage.copyWith(id: const Id("message_third"));

  late final messageNew = Stubs.textMessage;

  late final chat = Stubs.basicChat.copyWith(
    latestMessages: PaginatedList(
      items: [
        messageFirst,
        messageSecond,
        messageThird,
      ],
      pageInfo: const PageInfo.empty(),
    ),
  );

  setUp(() {
    registerFallbackValue(ChatMessageReactionType.empty());
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(
      () => ChatMocks.markMessageAsReadUseCase.execute(lastSeenMessageId: any(named: 'lastSeenMessageId')),
    ).thenAnswer((_) => successFuture(unit));

    useCase = ChatMessagesUseCase(
      chat,
      Mocks.clipboardManager,
      ChatMocks.prepareChatLiveDataClientUseCase,
      ChatMocks.getMessagesInChatUseCase,
      ChatMocks.sendChatMessageUseCase,
      ChatMocks.deleteMessageUseCase,
      ChatMocks.reactOnChatMessageUseCase,
      CirclesMocks.joinCircleUseCase,
      Mocks.uploadAttachmentUseCase,
      Mocks.attachmentRepository,
      ChatMocks.getUploadChatAttachmentUseCase,
      ChatMocks.markMessageAsReadUseCase,
      Mocks.userStore,
      Mocks.currentTimeProvider,
    );
  });

  Future<Either<ChatMessagesFailure, Stream<PaginatedList<DisplayableChatMessage>>>> _evaluateInitAction() async {
    final testDataClient = TestLiveDataClient<ChatEvent>();
    when(
      () => ChatMocks.prepareChatLiveDataClientUseCase.execute(),
    ).thenAnswer((_) => Future.value(testDataClient));
    return useCase.execute(
      action: ChatMessagesAction.init(chatIds: [Stubs.chat.id]),
    );
  }

  test(
    'use case action init executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await _evaluateInitAction();

      // THEN
      verify(
        () => ChatMocks.prepareChatLiveDataClientUseCase.execute(),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    'use case action init executes normally when messages are empty',
    () async {
      // GIVEN
      final useCaseWithEmptyChat = ChatMessagesUseCase(
        Stubs.basicChat.copyWith(
          latestMessages: const PaginatedList.singlePage(),
        ),
        Mocks.clipboardManager,
        ChatMocks.prepareChatLiveDataClientUseCase,
        ChatMocks.getMessagesInChatUseCase,
        ChatMocks.sendChatMessageUseCase,
        ChatMocks.deleteMessageUseCase,
        ChatMocks.reactOnChatMessageUseCase,
        CirclesMocks.joinCircleUseCase,
        Mocks.uploadAttachmentUseCase,
        Mocks.attachmentRepository,
        ChatMocks.getUploadChatAttachmentUseCase,
        ChatMocks.markMessageAsReadUseCase,
        Mocks.userStore,
        Mocks.currentTimeProvider,
      );

      final testDataClient = TestLiveDataClient<ChatEvent>();
      when(
        () => ChatMocks.prepareChatLiveDataClientUseCase.execute(),
      ).thenAnswer((_) => Future.value(testDataClient));

      // WHEN
      final result = await useCaseWithEmptyChat.execute(
        action: ChatMessagesAction.init(chatIds: [Stubs.chat.id]),
      );

      // THEN
      verify(
        () => ChatMocks.prepareChatLiveDataClientUseCase.execute(),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    'use case action loadMore executes normally',
    () async {
      // GIVEN

      final initResult = await _evaluateInitAction();

      final stream = initResult.getSuccess()!;

      when(
        () => ChatMocks.markMessageAsReadUseCase.execute(
          lastSeenMessageId: any(named: "lastSeenMessageId"),
        ),
      ).thenAnswer((_) => successFuture(unit));

      when(
        () => ChatMocks.getMessagesInChatUseCase.execute(
          chatId: any(named: "chatId"),
          nextPageCursor: any(named: "nextPageCursor"),
        ),
      ).thenAnswer((_) => successFuture(PaginatedList.singlePage([messageNew])));

      // WHEN
      final result = await useCase.execute(
        action: ChatMessagesAction.loadMore(),
      );

      stream.listen((event) {
        expect(event.items.length, 4);
        expect(event.items[3].chatMessage.id, messageNew.id);
      });

      // THEN
      verify(
        () => ChatMocks.getMessagesInChatUseCase.execute(
          nextPageCursor: any(named: "nextPageCursor"),
          chatId: any(named: "chatId"),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    'use case action sendMessage executes normally',
    () async {
      // GIVEN

      when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 6, 11));

      final initResult = await _evaluateInitAction();

      final stream = initResult.getSuccess()!;

      when(
        () => Mocks.uploadAttachmentUseCase.execute(
          attachments: any(named: "attachments"),
        ),
      ).thenAnswer((_) => successFuture(const []));

      when(
        () => ChatMocks.sendChatMessageUseCase.execute(
          chatId: any(named: "chatId"),
          message: any(named: "message"),
        ),
      ).thenAnswer((_) => successFuture(messageNew));

      // WHEN
      final result = await useCase.execute(
        action: ChatMessagesAction.sendMessage(
          message: Stubs.chatMessage,
          replyToMessage: null,
        ),
      );

      stream.listen((event) {
        expect(event.items.length, 4);
      });

      // THEN
      verify(
        () => ChatMocks.sendChatMessageUseCase.execute(
          chatId: any(named: "chatId"),
          message: any(named: "message"),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    'use case action deleteMessage executes normally',
    () async {
      // GIVEN

      final initResult = await _evaluateInitAction();

      final stream = initResult.getSuccess()!;

      when(
        () => ChatMocks.deleteMessageUseCase.execute(
          messageId: any(named: "messageId"),
        ),
      ).thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(
        action: ChatMessagesAction.deleteMessage(messageSecond),
      );

      stream.listen((event) {
        expect(event.items.length, 2);
        expect(event.items[0].chatMessage.id, messageFirst.id);
        expect(event.items[1].chatMessage.id, messageThird.id);
      });

      // THEN
      verify(
        () => ChatMocks.deleteMessageUseCase.execute(
          messageId: any(named: "messageId"),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    'use case action invertHeartReaction executes normally',
    () async {
      // GIVEN

      final initResult = await _evaluateInitAction();

      final stream = initResult.getSuccess()!;

      when(
        () => ChatMocks.reactOnChatMessageUseCase.execute(
          messageId: any(named: "messageId"),
          action: any(named: "action"),
          reactionType: any(named: "reactionType"),
        ),
      ).thenAnswer((_) => successFuture(Stubs.messageReaction));

      // WHEN
      final result = await useCase.execute(
        action: ChatMessagesAction.reaction(messageSecond, ChatMessageReactionType.heart()),
      );

      stream.listen((event) {
        expect(event.items.length, 3);
        expect(event.items[1].chatMessage.reactionsCount, Stubs.messageReaction.count);
      });

      // THEN
      verify(
        () => ChatMocks.reactOnChatMessageUseCase.execute(
          messageId: any(named: "messageId"),
          action: any(named: "action"),
          reactionType: any(named: "reactionType"),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    'use case action copy executes normally',
    () async {
      // GIVEN

      await _evaluateInitAction();

      when(() => Mocks.clipboardManager.saveText(any())).thenAnswer(
        (_) => successFuture(unit),
      );

      // WHEN
      final result = await useCase.execute(
        action: ChatMessagesAction.copy(messageSecond),
      );

      // THEN
      verify(
        () => Mocks.clipboardManager.saveText(any()),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<ChatMessagesUseCase>(param1: chat);
    expect(useCase, isNotNull);
  });
}
