import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/username_check_result.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/throttler.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';

void main() {
  late UsernameFormPresentationModel model;
  late UsernameFormPresenter presenter;
  late MockUsernameFormNavigator navigator;

  void _initMvp({UsernameSelectedCallback? onUsernameSelected}) {
    when(() => Mocks.checkUsernameAvailabilityUseCase.execute(username: any(named: 'username'))).thenSuccess(
      (invocation) => UsernameCheckResult(
        username: invocation.namedArguments[#username] as String,
        isTaken: false,
      ),
    );
    model = UsernameFormPresentationModel.initial(
      UsernameFormInitialParams(
        onUsernameSelected: onUsernameSelected ?? (_) async => doNothing(),
        formData: const OnboardingFormData.empty(),
      ),
      UsernameValidator(),
    );
    navigator = MockUsernameFormNavigator();
    presenter = UsernameFormPresenter(
      model,
      navigator,
      Debouncer(),
      Throttler(),
      Mocks.checkUsernameAvailabilityUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  }

  test(
    'tapping `continue` multiple times should call onUsernameSelected callback only once',
    () {
      fakeAsync(
        (async) {
          // GIVEN
          final completer = Completer();

          final mockUsernameSelected = MockUsernameSelected();
          when(() => mockUsernameSelected(any())).thenAnswer((invocation) {
            return completer.future;
          });
          _initMvp(
            onUsernameSelected: mockUsernameSelected,
          );

          // WHEN
          unawaited(presenter.onTapContinue());
          async.elapse(const Duration(milliseconds: 50));
          expect(presenter.state.continueEnabled, false);
          expect((presenter.state as UsernameFormPresentationModel).usernameSelectedResult.isPending(), true);
          unawaited(presenter.onTapContinue());
          async.elapse(const Duration(milliseconds: 50));
          expect(presenter.state.continueEnabled, false);
          unawaited(presenter.onTapContinue());
          async.elapse(const Duration(milliseconds: 150));
          expect(presenter.state.continueEnabled, false);
          unawaited(presenter.onTapContinue());
          async.elapse(const Duration(milliseconds: 4000));
          expect(presenter.state.continueEnabled, false);
          expect((presenter.state as UsernameFormPresentationModel).usernameSelectedResult.isPending(), true);
          completer.complete();
          //this makes sure that even after sign up usecase completes, we still show progress, to prevent
          // anyone from tapping on the button
          async.elapse(const Duration(milliseconds: 300));
          expect((presenter.state as UsernameFormPresentationModel).usernameSelectedResult.isPending(), true);

          async.elapse(const Duration(milliseconds: 1300));
          expect((presenter.state as UsernameFormPresentationModel).usernameSelectedResult.isPending(), false);

          // THEN
          verify(() => mockUsernameSelected(any())).called(1);

          unawaited(presenter.onTapContinue());
          verify(() => mockUsernameSelected(any())).called(1);
        },
      );
    },
  );

  setUp(() {});
}

class MockUsernameSelected extends Mock {
  Future<void> call(String username);
}
