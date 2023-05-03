import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';
import 'package:picnic_app/features/main/main_initial_params.dart';
import 'package:picnic_app/features/main/main_presentation_model.dart';
import 'package:picnic_app/features/main/main_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/main_mock_definitions.dart';

void main() {
  late MainPresentationModel model;
  late MainPresenter presenter;
  late MockMainNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 8, 16));
    when(() => Mocks.unreadCountersStore.unreadChats).thenReturn(List.empty());
    whenListen(
      Mocks.unreadCountersStore,
      Stream<List<UnreadChat>>.value(List.empty()),
    );
    model = MainPresentationModel.initial(
      const MainInitialParams(),
      Mocks.currentTimeProvider,
      Mocks.unreadCountersStore,
    );
    navigator = MockMainNavigator();
    presenter = MainPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.currentTimeProvider,
      Mocks.backgroundApiRepository,
      Mocks.unreadCountersStore,
    );
  });
}
