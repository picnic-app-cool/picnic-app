import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/onboarding_mock_definitions.dart';

void main() {
  late PermissionsFormPresentationModel model;
  late PermissionsFormPresenter presenter;
  late MockPermissionsFormNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    when(() => Mocks.appInfoStore.appInfo).thenReturn(Stubs.appInfo);

    model = PermissionsFormPresentationModel.initial(
      PermissionsFormInitialParams(onContinue: (_) {}),
      Mocks.appInfoStore,
    );
    navigator = MockPermissionsFormNavigator();
    presenter = PermissionsFormPresenter(
      model,
      navigator,
      Mocks.getRuntimePermissionStatusUseCase,
      Mocks.requestRuntimePermissionUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
