import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing_navigator.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing_presentation_model.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_use_case.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_initial_params.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_initial_params.dart';

class ChatDeeplinkRoutingPresenter extends Cubit<ChatDeeplinkRoutingViewModel> {
  ChatDeeplinkRoutingPresenter(
    super.model,
    this._navigator,
    this._getChatUseCase,
  );
  final ChatDeeplinkRoutingNavigator _navigator;
  final GetChatUseCase _getChatUseCase;

  ChatDeeplinkRoutingPresentationModel get _model => state as ChatDeeplinkRoutingPresentationModel;

  Future<void> init() {
    return _getChatUseCase.execute(chatId: _model.chatId).doOn(
          success: _handleChatResult,
          fail: _handleFail,
        );
  }

  void _handleChatResult(Chat chat) {
    switch (chat.chatType) {
      case ChatType.single:
        _navigator.openSingleChat(
          SingleChatInitialParams(chat: chat.toBasicChat()),
          pushAsReplacement: true,
        );
        break;
      case ChatType.circle:
        _navigator.openCircleChat(
          CircleChatInitialParams(chat: chat),
          pushAsReplacement: true,
        );
        break;
      case ChatType.group:
        _navigator.openGroupChat(
          GroupChatInitialParams.fromExistingChat(chat: chat.toBasicChat()),
          pushAsReplacement: true,
        );
        break;
    }
  }

  void _handleFail(HasDisplayableFailure error) => _navigator.showError(
        error.displayableFailure(),
        onTapButton: _navigator.close,
      );
}
