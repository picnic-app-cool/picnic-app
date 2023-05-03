import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_presenter.dart';

import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';

void main() {
  late CongratsFormPresentationModel model;
  late CongratsFormPresenter presenter;
  late MockCongratsFormNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = CongratsFormPresentationModel.initial(
      CongratsFormInitialParams(
        onTapContinue: () {},
      ),
    );
    navigator = MockCongratsFormNavigator();
    presenter = CongratsFormPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
