import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_navigator.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';

class ChatDeeplinkRoutingNavigator
    with NoRoutes, ErrorBottomSheetRoute, GroupChatRoute, SingleChatRoute, CircleChatRoute, CloseRoute {
  ChatDeeplinkRoutingNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ChatDeeplinkRoutingRoute {
  Future<void> openChatDeeplinkRouting(ChatDeeplinkRoutingInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<ChatDeeplinkRoutingPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
