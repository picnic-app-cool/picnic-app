import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/get_recommended_chats_input.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/get_recommended_chats_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/paginated_list_presenter/paginated_list_presenter.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_component_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_list_item_displayable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_component_input.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_input.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_type.dart';
import 'package:picnic_app/features/chat/domain/use_cases/send_chat_message_use_case.dart';
import 'package:picnic_app/features/posts/domain/model/share_recommendation_displayable.dart';
import 'package:picnic_app/features/posts/post_share/post_share_navigator.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presentation_model.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';

class PostSharePresenter extends Cubit<PostShareViewModel> {
  PostSharePresenter(
    super.model,
    this.navigator,
    this._logAnalyticsEventUseCase,
    this._getRecommendedChatsUseCase,
    this._sendChatMessageUseCase,
    this._userStore,
  );

  final PostShareNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final GetRecommendedChatsUseCase _getRecommendedChatsUseCase;
  final SendChatMessageUseCase _sendChatMessageUseCase;
  final UserStore _userStore;

  late final _recommendationsPresenter = PaginatedListPresenter<ShareRecommendationDisplayable>(
    getPresentationModel: () => _model.recommendations,
    modelUpdatedCallback: (recommendations) => tryEmit(_model.copyWith(recommendations: recommendations)),
    loadMoreFunction: (searchText, cursor) => _getRecommendedChatsUseCase
        .execute(
          input: GetRecommendedChatsInput(
            kind: ChatRecommendationKind.SharingPost,
            search: searchText,
            context: const GetRecommendedChatsContext.empty().copyWith(postId: _model.post.id.value),
            cursor: cursor,
          ),
        )
        .mapSuccess(
          (chats) => chats.mapItems(
            (chat) => ShareRecommendationDisplayable(
              chatDisplayable: chat.toChatListItemDisplayable(_userStore.privateProfile.user.id),
              isSent: false,
            ),
          ),
        ),
  );

  // ignore: unused_element
  PostSharePresentationModel get _model => state as PostSharePresentationModel;

  Future<void> loadMore({bool fromScratch = false}) async {
    await _recommendationsPresenter.loadMore(fromScratch: fromScratch);
  }

  void onChangedSearchText(String value) => _recommendationsPresenter.onChangedSearchText(value);

  void onMessageChanged(String message) => tryEmit(_model.copyWith(message: message));

  Future<void> onSendPressed(BasicChat chat) async {
    tryEmit(
      _model.byUpdatingSendState(isSent: true, chatId: chat.id),
    );
    await _sendChatMessageUseCase
        .execute(
          chatId: chat.id,
          message: const ChatMessageInput.empty().copyWith(
            content: _model.message,
            type: ChatMessageType.component,
            component: const ChatMessageComponentInput.empty().copyWith(
              type: ChatComponentType.post,
              entity: ChatMessageEntityInput(entityId: _model.post.id),
            ),
          ),
        )
        .doOn(
          fail: (error) => tryEmit(
            _model.byUpdatingSendState(isSent: false, chatId: chat.id),
          ),
        );
  }

  Future<void> onTapReport() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postReportLongTap,
      ),
    );
    await navigator.openReportForm(
      ReportFormInitialParams(
        circleId: _model.post.circle.id,
        entityId: _model.post.id,
        reportEntityType: ReportEntityType.post,
        contentAuthorId: _model.post.author.id,
      ),
    );
  }

  Future<void> onTapShare() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postShareButton,
      ),
    );
    await navigator.shareText(text: _model.post.shareLink);
  }
}
