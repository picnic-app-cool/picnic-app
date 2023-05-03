import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/validators/full_name_validator.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_initial_params.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_navigator.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_page.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/profile_mocks.dart';

Future<void> main() async {
  late EditProfilePage page;
  late EditProfileInitialParams initParams;
  late EditProfilePresentationModel model;
  late EditProfilePresenter presenter;
  late EditProfileNavigator navigator;

  void _initMvp() {
    initParams = const EditProfileInitialParams();
    model = EditProfilePresentationModel.initial(
      initParams,
      UsernameValidator(),
      FullNameValidator(),
    );
    navigator = EditProfileNavigator(Mocks.appNavigator);
    presenter = EditProfilePresenter(
      model,
      navigator,
      ProfileMocks.editProfileUseCase,
      Mocks.checkUsernameAvailabilityUseCase,
      Mocks.debouncer,
      ProfileMocks.updateProfileImageUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = EditProfilePage(presenter: presenter);
  }

  await screenshotTest(
    "edit_profile_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<EditProfilePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
