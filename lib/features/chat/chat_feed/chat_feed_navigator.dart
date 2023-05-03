import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_initial_params.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_page.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class ChatFeedNavigator with ChatFeedRoute, CircleDetailsRoute, CircleChatRoute {
  ChatFeedNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ChatFeedRoute {
  Future<void> openChatFeed(ChatFeedInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<ChatFeedPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
