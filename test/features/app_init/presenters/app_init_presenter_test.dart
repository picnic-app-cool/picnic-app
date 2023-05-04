import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/app_init_failure.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/app_init/app_init_initial_params.dart';
import 'package:picnic_app/features/app_init/app_init_presentation_model.dart';
import 'package:picnic_app/features/app_init/app_init_presenter.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../../force_update/mocks/force_update_mocks.dart';
import '../../profile/mocks/profile_mocks.dart';
import '../../user_agreement/mocks/user_agreement_mocks.dart';
import '../mocks/app_init_mock_definitions.dart';
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
      when(() => AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => successFuture(unit));
      when(() => navigator.openMain(any())).thenAnswer((_) => Future.value());
      when(() => navigator.openOnboarding(any())).thenAnswer((_) => Future.value());
      when(() => navigator.openForceUpdate(any())).thenAnswer((_) => Future.value());
      when(() => ForceUpdateMocks.shouldShowForceUpdateUseCase.execute()).thenAnswer((_) => Future.value(false));
      when(() => Mocks.setAppInfoUseCase.execute()).thenAnswer((_) => successFuture(unit));

      // WHEN
      await presenter.onInit();
      await presenter.onLogoAnimationEnd();

      // THEN
      verify(() => AppInitMocks.appInitUseCase.execute());
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
      when(() => AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => failFuture(const AppInitFailure.unknown()));
      when(() => ForceUpdateMocks.shouldShowForceUpdateUseCase.execute()).thenAnswer((_) => Future.value(false));
      when(() => Mocks.setAppInfoUseCase.execute()).thenAnswer((_) => successFuture(unit));

      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onInit();
      await presenter.onLogoAnimationEnd();

      // THEN
      verify(() => navigator.showError(any()));
    },
  );

  test(
    'should show update popup when the app version is less than the remote app version',
    () async {
      // GIVEN
      whenListen(
        Mocks.userStore,
        Stream.fromIterable([const PrivateProfile.empty()]),
      );
      when(() => AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => successFuture(unit));
      when(() => navigator.openMain(any())).thenAnswer((_) => Future.value());
      when(() => navigator.openOnboarding(any())).thenAnswer((_) => Future.value());
      when(() => navigator.openForceUpdate(any())).thenAnswer((_) => Future.value());
      when(() => ForceUpdateMocks.shouldShowForceUpdateUseCase.execute()).thenAnswer((_) => Future.value(true));
      when(() => Mocks.setAppInfoUseCase.execute()).thenAnswer((_) => successFuture(unit));

      // WHEN
      await presenter.onInit();

      //then
      verify(() => navigator.openForceUpdate(any()));
    },
  );

  test(
    'should show user agreement bottom sheet when user is logged in but did not accept terms before',
    () async {
      fakeAsync((async) {
        // GIVEN
        when(() => AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => successFuture(unit));
        when(
          () => navigator.openUserAgreementBottomSheet(
            onTapTerms: any(named: 'onTapTerms'),
            onTapPolicies: any(named: 'onTapPolicies'),
            onTapAccept: any(named: 'onTapAccept'),
          ),
        ).thenAnswer((_) => Future.value());
        when(() => ForceUpdateMocks.shouldShowForceUpdateUseCase.execute()).thenAnswer((_) => Future.value(false));
        when(() => UserAgreementMocks.hasUserAgreedToAppsTermsUseCase.execute()).thenSuccess((_) => false);

        // WHEN
        presenter.emit(
          model.copyWith(
            user: const PrivateProfile.empty().copyWith(
              user: const User.empty().copyWith(id: const Id('userId')),
            ),
          ),
        );
        presenter.onInit();
        async.flushMicrotasks();
        presenter.onLogoAnimationEnd();
        async.flushMicrotasks();

        // THEN
        verify(
          () => navigator.openUserAgreementBottomSheet(
            onTapTerms: any(named: 'onTapTerms'),
            onTapPolicies: any(named: 'onTapPolicies'),
            onTapAccept: any(named: 'onTapAccept'),
          ),
        );
      });
    },
  );

  test(
    'should not show user agreement bottom sheet but open main when user is logged in but already accepted the terms',
    () async {
      fakeAsync((async) {
        // GIVEN
        when(() => AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => successFuture(unit));
        when(() => navigator.openOnboarding(any())).thenAnswer((_) => Future.value());
        when(() => ForceUpdateMocks.shouldShowForceUpdateUseCase.execute()).thenAnswer((_) => Future.value(false));
        when(() => UserAgreementMocks.hasUserAgreedToAppsTermsUseCase.execute()).thenSuccess((_) => true);

        // WHEN
        presenter.emit(
          model.copyWith(
            user: const PrivateProfile.empty().copyWith(
              user: const User.empty().copyWith(id: const Id('userId')),
            ),
          ),
        );
        presenter.onInit();
        async.flushMicrotasks();
        presenter.onLogoAnimationEnd();

        // THEN
        verifyNever(
          () => navigator.openUserAgreementBottomSheet(
            onTapTerms: any(named: 'onTapTerms'),
            onTapPolicies: any(named: 'onTapPolicies'),
            onTapAccept: any(named: 'onTapAccept'),
          ),
        );
        verify(
          () => navigator.openOnboarding(any()),
        );
      });
    },
  );

  test(
    'should not show user agreement bottom sheet but open onBoarding when user is not logged in',
    () async {
      fakeAsync((async) {
        // GIVEN
        when(() => AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => successFuture(unit));
        when(() => navigator.openMain(any())).thenAnswer((_) => Future.value());
        when(() => ForceUpdateMocks.shouldShowForceUpdateUseCase.execute()).thenAnswer((_) => Future.value(false));
        when(() => UserAgreementMocks.hasUserAgreedToAppsTermsUseCase.execute()).thenSuccess((_) => true);

        // WHEN
        presenter.emit(
          model.copyWith(
            user: const PrivateProfile.anonymous(),
          ),
        );
        presenter.onInit();
        async.flushMicrotasks();
        presenter.onLogoAnimationEnd();
        async.flushMicrotasks();

        // THEN
        verifyNever(
          () => navigator.openUserAgreementBottomSheet(
            onTapTerms: any(named: 'onTapTerms'),
            onTapPolicies: any(named: 'onTapPolicies'),
            onTapAccept: any(named: 'onTapAccept'),
          ),
        );
        verify(
          () => navigator.openOnboarding(any()),
        );
      });
    },
  );

  test(
    'should show circles selection if getShouldShowCirclesSelectionUseCase returns true',
    () async {
      fakeAsync((async) {
        // GIVEN
        when(() => AppInitMocks.appInitUseCase.execute()).thenAnswer((_) => successFuture(unit));
        when(() => navigator.openMain(any())).thenAnswer((_) => Future.value());
        when(() => navigator.openOnBoardingCirclesPickerPage(any())).thenAnswer((_) => Future.value());
        when(() => ForceUpdateMocks.shouldShowForceUpdateUseCase.execute()).thenAnswer((_) => Future.value(false));
        when(() => Mocks.getShouldShowCirclesSelectionUseCase.execute()).thenAnswer((_) => successFuture(true));
        when(() => UserAgreementMocks.hasUserAgreedToAppsTermsUseCase.execute()).thenSuccess((_) => true);

        // WHEN
        presenter.emit(
          model.copyWith(
            user: const PrivateProfile.empty().copyWith(
              user: const User.empty().copyWith(id: const Id('userId')),
            ),
          ),
        );
        presenter.onInit();
        async.flushMicrotasks();
        presenter.onLogoAnimationEnd();
        async.flushMicrotasks();

        // THEN
        verify(() => navigator.openOnBoardingCirclesPickerPage(any()));
        verifyNever(() => navigator.openMain(any()));
      });
    },
  );

  setUp(() {
    model = AppInitPresentationModel.initial(const AppInitInitialParams());
    navigator = AppInitMocks.appInitNavigator;
    presenter = AppInitPresenter(
      model,
      navigator,
      AppInitMocks.appInitUseCase,
      ForceUpdateMocks.shouldShowForceUpdateUseCase,
      UserAgreementMocks.hasUserAgreedToAppsTermsUseCase,
      UserAgreementMocks.acceptAppsTermsUseCase,
      ProfileMocks.getPrivateProfileUseCase,
      Mocks.getShouldShowCirclesSelectionUseCase,
      Mocks.userStore,
      Mocks.localStoreRepository,
    );

    when(() => Mocks.getShouldShowCirclesSelectionUseCase.execute()).thenAnswer((_) => successFuture(false));
  });
}
