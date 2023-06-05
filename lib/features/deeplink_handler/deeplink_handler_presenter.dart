//ignore_for_file: forbidden_import_in_presentation
import 'dart:async';

import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/get_circle_by_name_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_by_username_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/listen_to_deep_links_use_case.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/deeplink_handler/deeplink_handler_navigator.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_circle.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_profile.dart';
import 'package:picnic_app/features/posts/post_details/post_details_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_initial_params.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_initial_params.dart';

class DeeplinkHandlerPresenter {
  DeeplinkHandlerPresenter(
    this._navigator,
    this._listenToDeepLinksUseCase,
    this._userStore,
    this._getUserByUsernameUseCase,
    this._circleByNameUseCase,
  );

  final DeeplinkHandlerNavigator _navigator;
  final ListenToDeepLinksUseCase _listenToDeepLinksUseCase;
  late final StreamSubscription<DeepLink> _eventSub;
  final UserStore _userStore;
  final GetUserByUsernameUseCase _getUserByUsernameUseCase;
  final GetCircleByNameUseCase _circleByNameUseCase;

  Future<void> onInit() async {
    _eventSub = _listenToDeepLinksUseCase
        .execute()
        .listen((link) => Future.delayed(const ShortDuration(), () => _processDeepLink(link)));
  }

  void onDispose() => _eventSub.cancel();

  void _processDeepLink(DeepLink deeplink) {
    if (deeplink.requiresAuthenticatedUser && !_userStore.isUserLoggedIn) {
      debugLog("User is not authenticated and deeplink requires to be, ignoring: $deeplink");
      return;
    }
    deeplink.when(
      onChatDeepLink: (deepLink) {
        _navigator.openChatDeeplinkRouting(ChatDeeplinkRoutingInitialParams(deepLink.chatId));
      },
      onProfileDeepLink: _handleProfileDeepLink,
      onCircleDeepLink: _handleCircleDeepLink,
      onPostDeepLink: (deepLink) => _navigator.openPostDetails(
        PostDetailsInitialParams.fromDeepLink(deepLink: deepLink),
      ),
      onUserSeeds: (deepLink) => _navigator.openSeeds(const SeedsInitialParams()),
      onElection: (deepLink) => _navigator.openCircleGovernance(
        CircleGovernanceInitialParams.byId(circleId: deepLink.circleId),
      ),
    );
  }

  void _handleCircleDeepLink(DeepLinkCircle deepLink) {
    if (deepLink.circleName.isNotEmpty) {
      _circleByNameUseCase.execute(name: deepLink.circleName).doOn(
            success: (circle) => _openCircleDetails(circle.id),
          );
    } else {
      _openCircleDetails(deepLink.circleId);
    }
  }

  void _handleProfileDeepLink(DeepLinkProfile deepLink) {
    if (deepLink.username.isNotEmpty) {
      _getUserByUsernameUseCase.execute(username: deepLink.username).doOn(
            success: (id) => _openProfile(id),
          );
    } else {
      _openProfile(deepLink.userId);
    }
  }

  void _openProfile(Id userId) {
    _navigator.openProfile(userId: userId);
  }

  void _openCircleDetails(Id circleId) {
    _navigator.openCircleDetails(
      CircleDetailsInitialParams(circleId: circleId),
    );
  }
}
