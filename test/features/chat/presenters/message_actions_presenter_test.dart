import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_initial_params.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_presentation_model.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_presenter.dart';
import 'package:picnic_app/features/chat/message_actions/model/message_actions_open_event.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

import '../../../mocks/stubs.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/chat_mock_definitions.dart';

void main() {
  late MessageActionsPresentationModel model;
  late MessageActionsPresenter presenter;
  late MockMessageActionsNavigator navigator;

  test(
    'deleteMessage test',
    () async {
      //GIVEN

      when(
        () => navigator.showConfirmationBottomSheet(
          title: any(named: "title"),
          message: any(named: "message"),
          primaryAction: any(named: "primaryAction"),
          secondaryAction: any(named: "secondaryAction"),
        ),
      ).thenAnswer((invocation) {
        final primaryAction = invocation.namedArguments[#primaryAction] as ConfirmationAction;
        primaryAction.action.call();
        return Future.value(true);
      });

      //WHEN
      presenter.onTapMenuItem(PopUpMenuItem.deleteMessageAction());

      //THEN
      verify(
        () => navigator.showConfirmationBottomSheet(
          title: any(named: "title"),
          message: any(named: "message"),
          primaryAction: any(named: "primaryAction"),
          secondaryAction: any(named: "secondaryAction"),
        ),
      );

      verify(
        () => navigator.close(),
      );

      verify(
        () => navigator.closeWithResult(PopUpMenuItem.deleteMessageAction()),
      );
    },
  );

  test(
    'deleteMessage negative test',
    () async {
      //GIVEN

      when(
        () => navigator.showConfirmationBottomSheet(
          title: any(named: "title"),
          message: any(named: "message"),
          primaryAction: any(named: "primaryAction"),
          secondaryAction: any(named: "secondaryAction"),
        ),
      ).thenAnswer((invocation) {
        final secondaryAction = invocation.namedArguments[#secondaryAction] as ConfirmationAction;
        secondaryAction.action.call();
        return Future.value(true);
      });

      //WHEN
      presenter.onTapMenuItem(PopUpMenuItem.deleteMessageAction());

      //THEN
      verify(
        () => navigator.showConfirmationBottomSheet(
          title: any(named: "title"),
          message: any(named: "message"),
          primaryAction: any(named: "primaryAction"),
          secondaryAction: any(named: "secondaryAction"),
        ),
      );

      verify(
        () => navigator.close(),
      );

      verifyNever(
        () => navigator.closeWithResult(PopUpMenuItem.deleteMessageAction()),
      );
    },
  );

  test(
    'banUser test',
    () async {
      //GIVEN

      when(
        () => navigator.showConfirmationBottomSheet(
          title: any(named: "title"),
          message: any(named: "message"),
          primaryAction: any(named: "primaryAction"),
          secondaryAction: any(named: "secondaryAction"),
        ),
      ).thenAnswer((invocation) {
        final primaryAction = invocation.namedArguments[#primaryAction] as ConfirmationAction;
        primaryAction.action.call();
        return Future.value(true);
      });

      //WHEN
      presenter.onTapMenuItem(PopUpMenuItem.banUserAction());

      //THEN
      verify(
        () => navigator.showConfirmationBottomSheet(
          title: any(named: "title"),
          message: any(named: "message"),
          primaryAction: any(named: "primaryAction"),
          secondaryAction: any(named: "secondaryAction"),
        ),
      );

      verify(
        () => navigator.close(),
      );

      verify(
        () => navigator.closeWithResult(PopUpMenuItem.banUserAction()),
      );
    },
  );

  test(
    'banUser negative test',
    () async {
      //GIVEN

      when(
        () => navigator.showConfirmationBottomSheet(
          title: any(named: "title"),
          message: any(named: "message"),
          primaryAction: any(named: "primaryAction"),
          secondaryAction: any(named: "secondaryAction"),
        ),
      ).thenAnswer((invocation) {
        final secondaryAction = invocation.namedArguments[#secondaryAction] as ConfirmationAction;
        secondaryAction.action.call();
        return Future.value(true);
      });

      //WHEN
      presenter.onTapMenuItem(PopUpMenuItem.banUserAction());

      //THEN
      verify(
        () => navigator.showConfirmationBottomSheet(
          title: any(named: "title"),
          message: any(named: "message"),
          primaryAction: any(named: "primaryAction"),
          secondaryAction: any(named: "secondaryAction"),
        ),
      );

      verify(
        () => navigator.close(),
      );

      verifyNever(
        () => navigator.closeWithResult(PopUpMenuItem.banUserAction()),
      );
    },
  );

  test(
    'All actions test except deleteMessage and banUser',
    () async {
      final actions = PopUpMenuItem.values.toList()
        ..remove(PopUpMenuItem.deleteMessageAction())
        ..remove(PopUpMenuItem.deleteMultipleMessagesAction())
        ..remove(PopUpMenuItem.banUserAction());
      for (final action in actions) {
        //WHEN
        presenter.onTapMenuItem(action);

        //THEN
        verify(
          () => navigator.closeWithResult(action),
        );
      }
    },
  );

  setUp(() {
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
    final initParams = MessageActionsInitialParams(
      event: event,
      popupMenuItems: PopUpMenuItem.values,
    );
    model = MessageActionsPresentationModel.initial(
      initParams,
    );

    navigator = MockMessageActionsNavigator();
    presenter = MessageActionsPresenter(
      model,
      AnalyticsMocks.logAnalyticsEventUseCase,
      navigator,
    );
  });
}
