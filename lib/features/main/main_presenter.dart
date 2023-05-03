import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/repositories/background_api_repository.dart';
import 'package:picnic_app/core/domain/stores/unread_counters_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/change/analytics_change_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';
import 'package:picnic_app/features/main/main_navigator.dart';
import 'package:picnic_app/features/main/main_presentation_model.dart';
import 'package:picnic_app/features/main/selected_tab_info.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_initial_params.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_nav_item.dart';

class MainPresenter extends Cubit<MainViewModel> with SubscriptionsMixin {
  MainPresenter(
    MainPresentationModel model,
    this.navigator,
    this._logAnalyticsEventUseCase,
    this._currentTimeProvider,
    this._backgroundApiRepository,
    UnreadCountersStore unreadCountersStore,
  ) : super(model) {
    listenTo<List<UnreadChat>>(
      stream: unreadCountersStore.stream,
      subscriptionId: _unreadCountersStoreSubscription,
      onChange: (unreadChats) => tryEmit(_model.copyWith(unreadChatsCount: unreadChats.length)),
    );
  }

  final MainNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final CurrentTimeProvider _currentTimeProvider;
  final BackgroundApiRepository _backgroundApiRepository;

  static const _unreadCountersStoreSubscription = "unreadCountersStoreMainSubscription";

  MainPresentationModel get _model => state as MainPresentationModel;

  void onSelectedTab(PicnicNavItem tab) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.change(
        target: AnalyticsChangeTarget.mainTab,
        targetValue: tab.value,
      ),
    );
    if (tab == PicnicNavItem.add) {
      if (_backgroundApiRepository.isNewCallAllowed()) {
        navigator.openPostCreation(const PostCreationIndexInitialParams());
      } else {
        navigator.showBackgroundCallsLimitReachedToast();
      }
    } else {
      final reopenTime = tab == _model.selectedTab.item ? _currentTimeProvider.currentTime : null;
      tryEmit(
        _model.copyWith(
          selectedTab: SelectedTabInfo(
            item: tab,
            initialOpenTime: _currentTimeProvider.currentTime,
            reopenTime: reopenTime,
          ),
        ),
      );
    }
  }

  void onPostChanged(Post post) {
    tryEmit(
      _model.copyWith(
        postOverlayTheme: post.overlayTheme,
      ),
    );
  }

  void onCirclesSideMenuToggled() {
    tryEmit(
      _model.copyWith(
        isCirclesSideMenuOpen: !_model.isCirclesSideMenuOpen,
      ),
    );
  }

  void onCircleSideMenuAction() {
    tryEmit(
      _model.copyWith(
        isCirclesSideMenuOpen: false,
      ),
    );
  }
}
