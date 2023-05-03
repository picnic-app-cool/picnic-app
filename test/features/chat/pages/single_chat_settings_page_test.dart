import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/settings/single_chat_settings.dart';

import '../../../mocks/mock_definitions.dart';
import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/chat_mock_definitions.dart';
import '../mocks/chat_mocks.dart';

Future<void> main() async {
  late SingleChatSettingsPage page;
  late SingleChatSettingsInitialParams initParams;
  late SingleChatSettingsPresentationModel model;
  late SingleChatSettingsPresenter presenter;
  late SingleChatSettingsNavigator navigator;

  void _initMvp() {
    when(() => Mocks.getUserUseCase.execute(userId: any(named: 'userId')))
        .thenAnswer((_) => successFuture(Stubs.publicProfile));
    when(() => ChatMocks.getChatSettingsUseCase.execute(chatId: any(named: 'chatId')))
        .thenAnswer((_) => successFuture(Stubs.chatSettings));

    initParams = const SingleChatSettingsInitialParams(Id.empty(), User.empty());
    model = SingleChatSettingsPresentationModel.initial(
      initParams,
    );
    navigator = SingleChatSettingsNavigator(Mocks.appNavigator);
    presenter = SingleChatSettingsPresenter(
      model,
      navigator,
      MockFollowUserUseCase(),
      MockUpdateChatSettingsUseCase(),
      Mocks.getUserUseCase,
      ChatMocks.getChatSettingsUseCase,
      Mocks.sendGlitterBombUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = SingleChatSettingsPage(presenter: presenter);
  }

  await screenshotTest(
    "single_chat_settings_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SingleChatSettingsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
