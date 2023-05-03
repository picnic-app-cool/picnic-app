import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_initial_params.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_navigator.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_page.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_presentation_model.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_presenter.dart';
import 'package:picnic_app/features/chat/message_actions/model/message_actions_open_event.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';

Future<void> main() async {
  late MessageActionsPage page;
  late MessageActionsInitialParams initParams;
  late MessageActionsPresentationModel model;
  late MessageActionsPresenter presenter;
  late MessageActionsNavigator navigator;

  void _initMvp() {
    final event = MessageActionsOpenEvent(
      sourceLeft: 50,
      sourceTop: 100,
      displayableMessage: DisplayableChatMessage(
        chatMessage: Stubs.chatMessage,
        previousMessage: Stubs.previousMessage,
        isFirstInGroup: true,
        isLastInGroup: true,
      ),
    );
    initParams = MessageActionsInitialParams(
      event: event,
      popupMenuItems: PopUpMenuItem.values,
    );
    model = MessageActionsPresentationModel.initial(
      initParams,
    );
    navigator = MessageActionsNavigator(Mocks.appNavigator);

    presenter = MessageActionsPresenter(
      model,
      AnalyticsMocks.logAnalyticsEventUseCase,
      navigator,
    );
    page = MessageActionsPage(presenter: presenter);
  }

  await screenshotTest(
    "message_actions_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<MessageActionsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
