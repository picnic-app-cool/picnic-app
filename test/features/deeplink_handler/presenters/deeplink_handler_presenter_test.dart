import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/deeplink_handler/deeplink_handler_presenter.dart';

import '../../../mocks/mock_definitions.dart';
import '../../../mocks/mocks.dart';
import '../mocks/deeplink_handler_mock_definitions.dart';

void main() {
  late DeeplinkHandlerPresenter presenter;
  late MockDeeplinkHandlerNavigator navigator;
  late MockListenToDeepLinksUseCase useCase;
  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    navigator = MockDeeplinkHandlerNavigator();
    useCase = Mocks.listenToDeepLinksUseCase;
    presenter = DeeplinkHandlerPresenter(
      navigator,
      useCase,
      Mocks.userStore,
      Mocks.getUserByUsernameUseCase,
      Mocks.getCircleByNameUseCase,
    );
  });
}
