import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/posts/post_details/post_details_navigator.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_navigator.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class DeeplinkHandlerNavigator
    with
        PostDetailsRoute,
        CircleDetailsRoute,
        ChatDeeplinkRoutingRoute,
        SeedsRoute,
        CircleGovernanceRoute,
        ProfileRoute {
  DeeplinkHandlerNavigator(this.appNavigator, this.userStore);

  @override
  final UserStore userStore;

  @override
  final AppNavigator appNavigator;
}
