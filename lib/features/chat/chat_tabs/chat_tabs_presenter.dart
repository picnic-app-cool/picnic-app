import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/change/analytics_change_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_navigator.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presentation_model.dart';
import 'package:picnic_app/features/chat/domain/model/chat_tab_type.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';

class ChatTabsPresenter extends Cubit<ChatTabsViewModel> {
  ChatTabsPresenter(
    ChatTabsPresentationModel model,
    this.navigator,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final ChatTabsNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  ChatTabsPresentationModel get _model => state as ChatTabsPresentationModel;

  void onTabChanged(ChatTabType type) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.change(
        target: AnalyticsChangeTarget.chatFeedPage,
        targetValue: type.value,
      ),
    );
    if (type != _model.selectedChatTabType) {
      tryEmit(
        _model.copyWith(selectedChatTabType: type),
      );
    }
  }

  void onTapProfile() => navigator.openPrivateProfile(const PrivateProfileInitialParams());

  void onTapSearch() => navigator.openDiscoverExplore(const DiscoverExploreInitialParams());
}
