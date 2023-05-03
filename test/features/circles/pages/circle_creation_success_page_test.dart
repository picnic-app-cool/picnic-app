import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_initial_params.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_navigator.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_page.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_presentation_model.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../posts/mocks/posts_mocks.dart';

Future<void> main() async {
  late CircleCreationSuccessPage page;
  late CircleCreationSuccessInitialParams initParams;
  late CircleCreationSuccessPresentationModel model;
  late CircleCreationSuccessPresenter presenter;
  late CircleCreationSuccessNavigator navigator;

  void _initMvp({
    RuntimePermissionStatus runtimePermissionStatus = RuntimePermissionStatus.granted,
  }) {
    initParams = CircleCreationSuccessInitialParams(
      circle: Stubs.circle.copyWith(moderationType: CircleModerationType.director),
      createPostInput: Stubs.createTextPostInput,
      createCircleWithoutPost: false,
    );
    model = CircleCreationSuccessPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = CircleCreationSuccessNavigator(Mocks.appNavigator);
    presenter = CircleCreationSuccessPresenter(
      model,
      navigator,
      Mocks.getContactsUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.notifyContactUseCase,
      Mocks.getPhoneContactsUseCase,
      PostsMocks.createPostUseCase,
      Mocks.debouncer,
    );
    when(
      () => Mocks.getContactsUseCase.execute(
        searchQuery: '',
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer(
      (_) => successFuture(
        Stubs.userContacts,
      ),
    );

    when(() => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.contacts))
        .thenAnswer((_) => successFuture(runtimePermissionStatus));
    when(
      () => Mocks.getPhoneContactsUseCase.execute(),
    ).thenAnswer(
      (_) => Future.value(Stubs.phoneContacts),
    );

    page = CircleCreationSuccessPage(presenter: presenter);
  }

  await screenshotTest(
    "circle_creation_success_page",
    variantName: "seeds_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.disable(FeatureFlagType.areSeedsEnabled),
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_creation_success_page",
    variantName: "seeds_enabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.enable(FeatureFlagType.areSeedsEnabled),
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_creation_success_page",
    variantName: "contact_permission_granted",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.disable(FeatureFlagType.areSeedsEnabled),
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_creation_success_page",
    variantName: "contact_permission_denied",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.disable(FeatureFlagType.areSeedsEnabled),
      );
      _initMvp(runtimePermissionStatus: RuntimePermissionStatus.denied);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    _initMvp();
    final page = getIt<CircleCreationSuccessPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
