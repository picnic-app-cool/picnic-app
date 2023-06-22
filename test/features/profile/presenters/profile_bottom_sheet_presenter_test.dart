import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_action_use_case.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../mocks/profile_mock_definitions.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late ProfileBottomSheetPresentationModel model;
  late ProfileBottomSheetPresenter presenter;
  late MockProfileBottomSheetNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    final initParams = ProfileBottomSheetInitialParams(
      userId: Stubs.publicProfile.id,
    );
    model = ProfileBottomSheetPresentationModel.initial(
      initParams,
      Mocks.userStore,
    );
    navigator = MockProfileBottomSheetNavigator();
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
  });
}
