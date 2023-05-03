import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_desktop_app/features/main/main_initial_params.dart';
import 'package:picnic_desktop_app/features/main/main_presentation_model.dart';
import 'package:picnic_desktop_app/features/main/main_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
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
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    model = MainPresentationModel.initial(
      const MainInitialParams(),
      Mocks.userStore,
    );
    navigator = MockMainNavigator();
    presenter = MainPresenter(
      model,
      navigator,
    );
  });
}
