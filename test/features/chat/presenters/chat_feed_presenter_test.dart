import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_initial_params.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_presenter.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/chat_mock_definitions.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late ChatFeedPresentationModel model;
  late ChatFeedPresenter presenter;
  late MockChatFeedNavigator navigator;

  test("onInit should initialize liveChatPresenter", () async {
    //GIVEN
    when(
      () => ChatMocks.liveChatsPresenter.onInit(
        getChatMessagesProvider: any(named: 'getChatMessagesProvider'),
        onChatMessagesUpdatedCallback: any(named: 'onChatMessagesUpdatedCallback'),
      ),
    ).thenAnswer((_) => Future.value());

    //WHEN
    await presenter.onInit();

    // THEN
    verify(
      () => ChatMocks.liveChatsPresenter.onInit(
        getChatMessagesProvider: any(named: 'getChatMessagesProvider'),
        onChatMessagesUpdatedCallback: any(named: 'onChatMessagesUpdatedCallback'),
      ),
    );
  });

  test("close should dispose liveChatPresenter", () async {
    //GIVEN
    when(
      () => ChatMocks.liveChatsPresenter.dispose(),
    ).thenAnswer((_) => Future.value());

    //WHEN
    await presenter.close();

    // THEN
    verify(
      () => ChatMocks.liveChatsPresenter.dispose(),
    );
  });

  test("on tap feed should should open circle chat", () async {
    //GIVEN
    final circle = Stubs.circle;

    when(
      () => navigator.openCircleChat(any()),
    ).thenAnswer(
      (_) => successFuture(unit),
    );

    //WHEN
    presenter.onTapFeed(circle);

    // THEN
    final capturedParams = verify(
      () => navigator.openCircleChat(captureAny()),
    ).captured.first as CircleChatInitialParams;

    expect(capturedParams.chat.id, circle.chat.id);
  });

  test("on tap circle should should open circle details", () async {
    //GIVEN
    final circle = Stubs.circle;

    when(
      () => navigator.openCircleDetails(any()),
    ).thenAnswer(
      (_) => Future.value(true),
    );

    //WHEN
    await presenter.onTapCircle(circle);

    // THEN
    final capturedParams = verify(
      () => navigator.openCircleDetails(captureAny()),
    ).captured.first as CircleDetailsInitialParams;

    expect(capturedParams.circleId, circle.id);
  });

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    model = ChatFeedPresentationModel.initial(
      const ChatFeedInitialParams(),
      Mocks.userStore,
    );
    navigator = MockChatFeedNavigator();
    presenter = ChatFeedPresenter(
      model,
      navigator,
      ChatMocks.getChatFeedsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      ChatMocks.liveChatsPresenter,
    );
  });
}
