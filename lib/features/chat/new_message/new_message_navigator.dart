import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_navigator.dart';
import 'package:picnic_app/features/chat/new_message/new_message_initial_params.dart';
import 'package:picnic_app/features/chat/new_message/new_message_page.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class NewMessageNavigator with SingleChatRoute, ErrorBottomSheetRoute, GroupChatRoute {
  NewMessageNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin NewMessageRoute {
  Future<void> openNewMessage(NewMessageInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<NewMessagePage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}
