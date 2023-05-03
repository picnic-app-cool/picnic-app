import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/posts/post_details/post_details_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_navigator.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class DeeplinkHandlerNavigator
    with
        PostDetailsRoute,
        PublicProfileRoute,
        PrivateProfileRoute,
        CircleDetailsRoute,
        ChatDeeplinkRoutingRoute,
        SeedsRoute,
        CircleElectionRoute {
  DeeplinkHandlerNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}
