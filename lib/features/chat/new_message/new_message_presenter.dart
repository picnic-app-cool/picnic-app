import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/search_users_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/upload_attachment_use_case.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/presentation/selectable_user.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_input.dart';
import 'package:picnic_app/features/chat/domain/model/create_group_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/create_single_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/send_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/use_cases/create_group_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/create_single_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_upload_chat_attachment_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/send_chat_message_use_case.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_initial_params.dart';
import 'package:picnic_app/features/chat/new_message/new_message_navigator.dart';
import 'package:picnic_app/features/chat/new_message/new_message_presentation_model.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_initial_params.dart';
import 'package:picnic_app/features/media_picker/media_picker_presenter.dart';

class NewMessagePresenter extends Cubit<NewMessageViewModel> with SubscriptionsMixin, MediaPickerMediator {
  NewMessagePresenter(
    NewMessagePresentationModel model,
    this.navigator,
    this.mediaPickerPresenter,
    this._searchUsersUseCase,
    this._debouncer,
    this._createGroupChatUseCase,
    this._createSingleChatUseCase,
    this._sendChatMessageUseCase,
    this._uploadAttachmentUseCase,
    this._getUploadChatAttachmentUseCase,
    this._logAnalyticsEventUseCase,
    UserStore userStore,
  ) : super(model) {
    mediaPickerPresenter.setMediator(this);
    listenTo<PrivateProfile>(
      stream: userStore.stream,
      subscriptionId: _userStoreSubscription,
      onChange: (user) => tryEmit(_model.copyWith(privateProfile: user)),
    );
  }

  final NewMessageNavigator navigator;
  final MediaPickerPresenter mediaPickerPresenter;
  final SearchUsersUseCase _searchUsersUseCase;
  final CreateGroupChatUseCase _createGroupChatUseCase;
  final CreateSingleChatUseCase _createSingleChatUseCase;
  final SendChatMessageUseCase _sendChatMessageUseCase;
  final UploadAttachmentUseCase _uploadAttachmentUseCase;
  final GetUploadChatAttachmentUseCase _getUploadChatAttachmentUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final Debouncer _debouncer;

  static const _userStoreSubscription = "newMessageUserStoreSubscription";

  // ignore: unused_element
  NewMessagePresentationModel get _model => state as NewMessagePresentationModel;

  Future<Either<CreateSingleChatFailure, BasicChat>> get _createSingleChat =>
      _createSingleChatUseCase.execute(userIds: _model.userIds);

  Future<Either<CreateGroupChatFailure, BasicChat>> get _createGroupChat =>
      _createGroupChatUseCase.execute(name: _model.groupName, userIds: _model.userIds);

  void onInitState() {
    loadMoreUsers();
  }

  void searchInputFocusChanged({required bool hasFocus}) {
    if (hasFocus) {
      tryEmit(
        _model.copyWith(resizeToAvoidBottomInset: false),
      );
    }
  }

  void groupInputFocusChanged({required bool hasFocus}) {
    if (hasFocus) {
      tryEmit(
        _model.copyWith(resizeToAvoidBottomInset: false),
      );
    }
  }

  void chatInputFocusChanged({required bool hasFocus}) {
    if (hasFocus) {
      tryEmit(
        _model.copyWith(resizeToAvoidBottomInset: true),
      );
    }
  }

  void onChangedSearchText(String value) {
    if (value != _model.searchText) {
      _debouncer.debounce(
        const LongDuration(),
        () {
          tryEmit(_model.copyWith(searchText: value));
          loadMoreUsers(fromScratch: true);
        },
      );
    }
  }

  void onGroupNameUpdated(String value) => tryEmit(_model.copyWith(groupName: value));

  void onTapAddAttachment() => tryEmit(_model.byTogglingMediaPickerVisibility());

  @override
  void onSelectedAttachmentsChanged({required List<Attachment> attachments}) {
    tryEmit(
      _model.copyWith(selectedAttachments: attachments),
    );
  }

  @override
  Future<void> onDocumentsPicked({required List<Attachment> documents}) async {
    tryEmit(
      _model.copyWith(selectedAttachments: documents),
    );
    await _createChat();
  }

  void onTapDeleteAttachment(Attachment attachment) => mediaPickerPresenter.onTapDeleteAttachment(attachment);

  void onTapSendNewMassage() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.chatSendButton,
      ),
    );
    tryEmit(_model.copyWith(isMediaPickerVisible: false));
    _createChat();
  }

  void onTapAddRecipient(User user) {
    if (!_model.recipients.contains(user)) {
      final newRecipients = [..._model.recipients, user];
      tryEmit(
        _model.copyWith(
          recipients: newRecipients,
          users: _model.users.getUpdatedSelectableUsers(newRecipients),
        ),
      );
    }
  }

  void onTapRemoveRecipient(User user) {
    if (_model.recipients.contains(user)) {
      final newRecipients = [..._model.recipients]..remove(user);
      tryEmit(
        _model.copyWith(
          recipients: newRecipients,
          users: _model.users.getUpdatedSelectableUsers(newRecipients),
        ),
      );
    }
  }

  void onMessageTextUpdated(String value) => tryEmit(_model.copyWith(newMessageText: value));

  Future<void> loadMoreUsers({bool fromScratch = false}) {
    if (fromScratch) {
      tryEmit(_model.copyWith(users: const PaginatedList.empty()));
    }
    return _searchUsersUseCase
        .execute(
          query: _model.searchText,
          nextPageCursor: _model.usersCursor,
          ignoreMyself: true,
        )
        .doOn(
          success: (list) => tryEmit(
            _model.byAppendingFriendsList(list.getSelectableUsers(_model.recipients)),
          ),
        );
  }

  //Create or join to existing chat, BE decides in the response we expect chat object
  Future<void> _createChat() async {
    await (_model.isGroup ? _createGroupChat : _createSingleChat) //
        .doOnSuccessWait(_sendPendingMessage)
        .doOn(success: _openChat)
        .observeStatusChanges((result) => tryEmit(_model.copyWith(createChatResult: result)));
  }

  Future<void> _sendPendingMessage(BasicChat chat) async {
    final chatMessage = _model.chatMessage;
    if (chatMessage.content.isNotEmpty || _model.selectedAttachments.isNotEmpty) {
      await _model.selectedAttachments
          .map((attachment) => _getUploadChatAttachmentUseCase.execute(attachment: attachment))
          .zip()
          .mapFailure(SendChatMessageFailure.unknown)
          .flatMap(
            (attachments) =>
                _uploadAttachmentUseCase.execute(attachments: attachments).mapFailure(SendChatMessageFailure.unknown),
          )
          .mapSuccess(
            (attachments) => ChatMessageInput.fromChatMessage(message: chatMessage).copyWith(
              attachmentIds: attachments
                  .map(
                    (attachment) => attachment.id,
                  )
                  .toList(),
            ),
          )
          .flatMap(
            (messageInput) => _sendChatMessageUseCase.execute(
              chatId: chat.id,
              message: messageInput,
            ),
          )
          .doOn(fail: (fail) => logError(fail.cause));
    }
  }

  void _openChat(BasicChat chat) {
    _model.isGroup ? _openGroupChat(chat) : _openSingleChat(chat);
  }

  void _openGroupChat(BasicChat chat) {
    navigator.openGroupChat(
      GroupChatInitialParams.fromNewMessage(
        chat: chat,
        chatMessage: _model.chatMessage,
      ),
      pushAsReplacement: true,
    );
  }

  void _openSingleChat(BasicChat chat) {
    assert(_model.recipients.length == 1);
    navigator.openSingleChat(
      SingleChatInitialParams(
        chat: chat,
      ),
      pushAsReplacement: true,
    );
  }
}

extension GetSelectableUsers on PaginatedList<PublicProfile> {
  PaginatedList<Selectable<User>> getSelectableUsers(List<User> recipients) {
    return mapItems((user) => user.user.toSelectableUser(selected: recipients.contains(user)));
  }
}

extension GetUpdatedSelectableUsers on PaginatedList<Selectable<User>> {
  PaginatedList<Selectable<User>> getUpdatedSelectableUsers(List<User> recipients) {
    return mapItems((item) => item.copyWith(selected: recipients.contains(item.item)));
  }
}
