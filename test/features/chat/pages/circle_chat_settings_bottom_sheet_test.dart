import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_bottom_sheet.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_initial_params.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_navigator.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_presentation_model.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/chat_mocks.dart';

Future<void> main() async {
  late CircleChatSettingsBottomSheet page;
  late CircleChatSettingsInitialParams initParams;
  late CircleChatSettingsPresentationModel model;
  late CircleChatSettingsPresenter presenter;
  late CircleChatSettingsNavigator navigator;

  late final chatSettings = Stubs.chatSettings;
  late final circle = Stubs.circle.copyWith(chat: Stubs.basicChat);

  void _initMvp() {
    initParams = CircleChatSettingsInitialParams(circle: circle);
    model = CircleChatSettingsPresentationModel.initial(
      initParams,
    );
    navigator = CircleChatSettingsNavigator(Mocks.appNavigator);

    when(
      () => ChatMocks.getChatSettingsUseCase.execute(chatId: any(named: "chatId")),
    ).thenAnswer(
      (_) => successFuture(chatSettings),
    );

    presenter = CircleChatSettingsPresenter(
      model,
      navigator,
      Mocks.leaveCircleUseCase,
      ChatMocks.getChatSettingsUseCase,
      ChatMocks.updateChatSettingsUseCase,
      Mocks.joinCircleUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = CircleChatSettingsBottomSheet(presenter: presenter);
  }

  await screenshotTest(
    "circle_chat_settings_bottom_sheet",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<CircleChatSettingsBottomSheet>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
