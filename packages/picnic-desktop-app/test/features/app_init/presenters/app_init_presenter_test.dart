import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/app_init_failure.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_initial_params.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_presentation_model.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/app_init_mock_definitions.dart';
import '../../../../../../test/features/app_init/mocks/app_init_mocks.dart' as picnic_app;
import '../mocks/app_init_mocks.dart';

void main() {
  late AppInitPresentationModel model;
  late AppInitPresenter presenter;
  late MockAppInitNavigator navigator;

  test(
    'should call appInitUseCase on start',
    () async {
      // GIVEN
      whenListen(
        Mocks.userStore,
        Stream.fromIterable([const PrivateProfile.empty()]),
      );
      when(() => picnic_app.AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => successFuture(unit));
      when(() => Mocks.enableLaunchAtStartupUseCase.execute()).thenAnswer((_) => successFuture(unit));
      when(() => navigator.openMain(any())).thenAnswer((_) => Future.value());
      when(() => navigator.openOnboarding(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onInit();

      // THEN
      verify(() => picnic_app.AppInitMocks.appInitUseCase.execute());
      verify(() => Mocks.userStore.stream);
    },
  );
  test(
    'should show error when appInitUseCase fails',
    () async {
      // GIVEN
      whenListen(
        Mocks.userStore,
        Stream.fromIterable([const PrivateProfile.empty()]),
      );
      when(() => picnic_app.AppInitMocks.appInitUseCase.execute())
          .thenAnswer((_) => failFuture(const AppInitFailure.unknown()));
      when(() => Mocks.enableLaunchAtStartupUseCase.execute()).thenAnswer((_) => successFuture(unit));
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onInit();

      // THEN
      verify(() => navigator.showError(any()));
    },
  );

  setUp(() {
    model = AppInitPresentationModel.initial(const AppInitInitialParams());
    navigator = AppInitMocks.appInitNavigator;
    presenter = AppInitPresenter(
      model,
      navigator,
      picnic_app.AppInitMocks.appInitUseCase,
      Mocks.userStore,
      Mocks.enableLaunchAtStartupUseCase,
    );
  });
}
