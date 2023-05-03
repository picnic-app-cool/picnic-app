import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';

import '../../mocks/mocks.dart';

void main() {
  late OnboardingNavigator navigator;
  test(
    'showing circle selection should close all previous pages',
    () async {
      await navigator.openOnBoardingCirclesPickerPage(
        OnBoardingCirclesPickerInitialParams(
          onCirclesSelected: (_) => doNothing(),
          formData: const OnboardingFormData.empty(),
        ),
      );
      verify(
        () => Mocks.appNavigator.pushAndRemoveUntilRoot<void>(
          any(),
          context: any(named: 'context'),
        ),
      );
    },
  );

  setUp(() {
    navigator = OnboardingNavigator(Mocks.appNavigator, GlobalKey());
    when(() => Mocks.appNavigator.pushAndRemoveUntilRoot<void>(any())).thenAnswer((invocation) => Future.value());
  });
}
