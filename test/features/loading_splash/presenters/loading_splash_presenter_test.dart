import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_initial_params.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_presentation_model.dart';
import 'package:picnic_app/features/loading_splash/loading_splash_presenter.dart';

import '../mocks/loading_splash_mock_definitions.dart';

void main() {
  late LoadingSplashPresentationModel model;
  late LoadingSplashPresenter presenter;
  late MockLoadingSplashNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = LoadingSplashPresentationModel.initial(const LoadingSplashInitialParams());
    navigator = MockLoadingSplashNavigator();
    presenter = LoadingSplashPresenter(
      model,
      navigator,
    );
  });
}
