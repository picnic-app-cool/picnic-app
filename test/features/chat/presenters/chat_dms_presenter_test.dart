import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_initial_params.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/chat_mock_definitions.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late ChatDmsPresentationModel model;
  late ChatDmsPresenter presenter;
  late MockChatDmsNavigator navigator;

  setUp(() {
    model = ChatDmsPresentationModel.initial(const ChatDmsInitialParams(), Mocks.currentTimeProvider);
    navigator = MockChatDmsNavigator();
    presenter = ChatDmsPresenter(
      model,
      navigator,
      ChatMocks.getChatsUseCase,
      ChatMocks.leaveChatUseCase,
      ChatMocks.getSingleChatRecipientUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.userStore,
      Mocks.unreadCountersStore,
    );
  });

  test(
    'tapping chat should calls getSingleChatRecipientUseCase execution '
    'and openSingleChat() from navigator to open Single Chat',
    () {
      //GIVEN
      when(
        () => ChatMocks.getSingleChatRecipientUseCase.execute(
          chatId: any(named: 'chatId'),
        ),
      ).thenAnswer(
        (_) => successFuture(Stubs.user),
      );
      when(
        () => navigator.openSingleChat(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      //WHEN
      presenter.onTapChat(Stubs.singleChat);

      //THEN
      verify(
        () => ChatMocks.getSingleChatRecipientUseCase.execute(
          chatId: any(named: 'chatId'),
        ),
      ).called(1);
    },
  );

  test(
    'tapping chat should call openGroupChat() from navigator to open Group Chat',
    () {
      //GIVEN
      when(
        () => navigator.openGroupChat(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      //WHEN
      presenter.onTapChat(Stubs.groupChat);

      //THEN
      verify(
        () => navigator.openGroupChat(any()),
      ).called(1);
    },
  );

  test(
    'tapping create new message should call openNewMessage() form navigator to open New Message',
    () {
      //GIVEN
      when(
        () => navigator.openNewMessage(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      //WHEN
      presenter.onTapCreateNewMessage();

      //THEN
      verify(
        () => navigator.openNewMessage(any()),
      ).called(1);
    },
  );

  test(
    'tapping leave chat should calls leaveChatUseCase execution '
    'and showConfirmLeaveChatRoute() from navigator to show Confirmation',
    () async {
      //GIVEN
      when(
        () => ChatMocks.leaveChatUseCase.execute(chatId: any(named: "chatId")),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      when(() => navigator.showConfirmLeaveChatRoute(onTapLeave: any(named: "onTapLeave"))) //
          .thenAnswer((invocation) {
        final callback = invocation.namedArguments[#onTapLeave] as VoidCallback;
        callback.call();
        return Future.value(true);
      });

      //WHEN
      await presenter.onTapConfirmLeaveChat(Stubs.basicChat);

      //THEN
      verify(
        () => ChatMocks.leaveChatUseCase.execute(
          chatId: any(named: "chatId"),
        ),
      ).called(1);
    },
  );
}
