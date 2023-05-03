import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_initial_params.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presenter.dart';
import 'package:picnic_app/features/chat/domain/model/chat_tab_type.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/chat_mock_definitions.dart';

void main() {
  late ChatTabsPresentationModel model;
  late ChatTabsPresenter presenter;
  late MockChatTabsNavigator navigator;

  setUp(() {
    when(() => Mocks.unreadCountersStore.unreadChats).thenReturn(List.empty());
    whenListen(
      Mocks.unreadCountersStore,
      Stream<List<UnreadChat>>.value(List.empty()),
    );

    model = ChatTabsPresentationModel.initial(
      const ChatTabsInitialParams(),
    );
    navigator = MockChatTabsNavigator();
    presenter = ChatTabsPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });

  test(
    'on tap changed',
    () {
      // WHEN
      presenter.onTabChanged(ChatTabType.dms);

      // THEN
      expect(presenter.state.selectedChatTabType, ChatTabType.dms);
    },
  );

  test(
    'tapping profile should call openPrivateProfile() from navigator to open Private profile',
    () {
      // GIVEN
      when(
        () => navigator.openPrivateProfile(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      // WHEN
      presenter.onTapProfile();

      // THEN
      verify(
        () => navigator.openPrivateProfile(any()),
      ).called(1);
    },
  );

  test(
    // 'on tap search and open Discovery Explore',
    'tapping search should call openDiscoverExplore() from navigator to open Discovery Explore',
    () {
      // GIVEN
      when(
        () => navigator.openDiscoverExplore(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      // WHEN
      presenter.onTapSearch();

      // THEN
      verify(
        () => navigator.openDiscoverExplore(any()),
      ).called(1);
    },
  );
}
