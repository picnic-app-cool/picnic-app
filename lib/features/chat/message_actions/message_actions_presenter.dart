import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_navigator.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_presentation_model.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

class MessageActionsPresenter extends Cubit<MessageActionsViewModel> {
  MessageActionsPresenter(
    super.model,
    this._logAnalyticsEventUseCase,
    this.navigator,
  );

  final MessageActionsNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  void onTapReaction(ChatMessageReactionType chatMessageReactionType) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatMessageReactTap,
      ),
    );
    navigator.closeWithReaction(chatMessageReactionType);
  }

  void onTapMenuItem(PopUpMenuItem menuItemType) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatMessageMenuTap,
        targetValue: menuItemType.label,
      ),
    );
    menuItemType.when(
      delete: () => _deleteMessageAction(),
      ban: () => _banUserAction(),
      orElse: () => navigator.closeWithResult(menuItemType),
    );
  }

  void _deleteMessageAction() {
    navigator.showConfirmationBottomSheet(
      title: appLocalizations.deleteMessageTitle,
      message: appLocalizations.deleteMessageMessage,
      primaryAction: ConfirmationAction(
        title: appLocalizations.deleteMessageConfirmAction,
        action: () {
          navigator.close();
          navigator.closeWithResult(PopUpMenuItem.deleteMessageAction());
        },
      ),
      secondaryAction: ConfirmationAction.negative(
        action: () => navigator.close(),
      ),
    );
  }

  void _banUserAction() {
    navigator.showConfirmationBottomSheet(
      title: appLocalizations.banUserTitle,
      message: appLocalizations.banUserMessage,
      primaryAction: ConfirmationAction(
        title: appLocalizations.banUserConfirmAction,
        action: () {
          navigator.close();
          navigator.closeWithResult(PopUpMenuItem.banUserAction());
        },
      ),
      secondaryAction: ConfirmationAction.negative(
        action: () => navigator.close(),
      ),
    );
  }
}
