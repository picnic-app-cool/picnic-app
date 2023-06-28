import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_navigator.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presentation_model.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presenter.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
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

    when(() => OnboardingMocks.getOnBoardingInterestsUseCase.execute(any())).thenAnswer(
      (_) => successFuture(
        Stubs.onBoardingInterests,
      ),
    );

    await presenter.onInit();

    verify(() => Mocks.setShouldShowCirclesSelectionUseCase.execute(shouldShow: true));
  });

  setUp(() {
    model = OnBoardingCirclesPickerPresentationModel.initial(
      OnBoardingCirclesPickerInitialParams(
        onCirclesSelected: (List<Id> value) {},
        formData: const OnboardingFormData.empty(),
      ),
    );
    navigator = MockOnBoardingCirclesPickerNavigator();
    presenter = OnBoardingCirclesPickerPresenter(
      model,
      navigator,
      OnboardingMocks.getOnBoardingInterestsUseCase,
      CirclesMocks.joinCirclesUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.setShouldShowCirclesSelectionUseCase,
      OnboardingMocks.getCirclesForInterestsUseCase,
    );
  });
}
