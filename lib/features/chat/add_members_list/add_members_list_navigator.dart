import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_initial_params.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';

class AddMembersListNavigator with CloseRoute {
  AddMembersListNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin AddMembersListRoute {
  Future<void> openAddMembersList(AddMembersListInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<AddMembersListPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
