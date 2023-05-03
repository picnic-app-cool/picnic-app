import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_navigator.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presentation_model.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presenter.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';
import '../mocks/onboarding_mocks.dart';

void main() {
  late OnBoardingCirclesPickerPresentationModel model;
  late OnBoardingCirclesPickerPresenter presenter;
  late OnBoardingCirclesPickerNavigator navigator;

  test('setShouldShowCirclesSelectionUseCase should set the bool to true', () async {
    when(() => Mocks.setShouldShowCirclesSelectionUseCase.execute(shouldShow: true)).thenAnswer(
      (_) => successFuture(true),
    );

    when(() => OnboardingMocks.getOnBoardingCirclesUseCase.execute()).thenAnswer(
      (_) => successFuture([]),
    );

    await presenter.onInit();

    verify(() => Mocks.setShouldShowCirclesSelectionUseCase.execute(shouldShow: true));
  });

  setUp(() {
    model = OnBoardingCirclesPickerPresentationModel.initial(
      OnBoardingCirclesPickerInitialParams(
        onCirclesSelected: (List<BasicCircle> value) {},
        formData: const OnboardingFormData.empty(),
      ),
    );
    navigator = MockOnBoardingCirclesPickerNavigator();
    presenter = OnBoardingCirclesPickerPresenter(
      model,
      navigator,
      OnboardingMocks.getOnBoardingCirclesUseCase,
      CirclesMocks.joinCirclesUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.setShouldShowCirclesSelectionUseCase,
    );
  });
}
