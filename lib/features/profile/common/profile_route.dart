import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_page.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

mixin ProfileRoute {
  Future<bool?> openProfile({
    required Id userId,
  }) async {
    return userStore.privateProfile.id == userId
        ? appNavigator.push(
            materialRoute(getIt<PrivateProfilePage>(param1: const PrivateProfileInitialParams())),
            useRoot: true,
          )
        : appNavigator.push(
            materialRoute(getIt<PublicProfilePage>(param1: PublicProfileInitialParams(userId: userId))),
            useRoot: true,
          );
  }

  UserStore get userStore;

  AppNavigator get appNavigator;
}
