import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_initial_params.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_page.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

//ignore_for_file: unused-code
class ChatMyCirclesNavigator with CircleChatRoute, ErrorBottomSheetRoute {
  ChatMyCirclesNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ChatMyCirclesRoute {
  Future<void> openChatMyCircles(ChatMyCirclesInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(ChatMyCirclesPage(initialParams: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
