import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/profile/domain/model/public_profile_action.dart';

class GetUserActionUseCase {
  const GetUserActionUseCase();

  PublicProfileAction execute(PublicProfile user) {
    if (user.isBlocked) {
      return PublicProfileAction.blocked;
    }
    if (user.iFollow) {
      return user.followsMe ? PublicProfileAction.glitterbomb : PublicProfileAction.following;
    }

    return PublicProfileAction.follow;
  }
}
