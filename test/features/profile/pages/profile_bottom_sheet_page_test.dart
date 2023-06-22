import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_action_use_case.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_page.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../mocks/profile_mocks.dart';

Future<void> main() async {
  late ProfileBottomSheetPage page;
  late ProfileBottomSheetInitialParams initParams;
  late ProfileBottomSheetPresentationModel model;
  late ProfileBottomSheetPresenter presenter;
  late ProfileBottomSheetNavigator navigator;

  void initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    whenListen(
      Mocks.userStore,
      Stream.fromIterable([Stubs.privateProfile]),
    );
    when(() => Mocks.getUserUseCase.execute(userId: any(named: 'userId')))
        .thenAnswer((invocation) => successFuture(Stubs.publicProfile));

    when(() => ProfileMocks.getProfileStatsUseCase.execute(userId: any(named: 'userId')))
        .thenAnswer((invocation) => successFuture(Stubs.profileStats));

    initParams = ProfileBottomSheetInitialParams(
      userId: Stubs.publicProfile.id,
    );
    model = ProfileBottomSheetPresentationModel.initial(
      initParams,
      Mocks.userStore,
    );
    navigator = ProfileBottomSheetNavigator(Mocks.appNavigator);
    presenter = ProfileBottomSheetPresenter(
      model,
      navigator,
      Mocks.getUserUseCase,
      Mocks.followUserUseCase,
      const GetUserActionUseCase(),
      Mocks.sendGlitterBombUseCase,
      ChatMocks.createSingleChatUseCase,
      ProfileMocks.getProfileStatsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.clipboardManager,
    );

    getIt.registerFactoryParam<ProfileBottomSheetPresenter, ProfileBottomSheetInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = ProfileBottomSheetPage(presenter: presenter);
  }

  await screenshotTest(
    "profile_bottom_sheet_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
