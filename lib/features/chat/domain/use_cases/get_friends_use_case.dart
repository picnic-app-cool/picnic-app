import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/get_friends_failure.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

class GetFriendsUseCase with FutureRetarder {
  const GetFriendsUseCase();

  /// TODO remove once backend connected
  static List<User> get _list => [
        const User.empty().copyWith(
          username: 'brad',
          bio: 'Guys. I make the sickest beats.',
          profileImageUrl: const ImageUrl('📱'),
        ),
        const User.empty().copyWith(
          username: 'lucky',
          bio: 'Future is now',
          profileImageUrl: const ImageUrl('👽'),
        ),
        const User.empty().copyWith(
          username: 'denis',
          bio: 'Go on',
          profileImageUrl: const ImageUrl('🛶'),
        ),
        const User.empty().copyWith(
          username: 'lili',
          bio: 'Like it',
          profileImageUrl: const ImageUrl('🌻'),
        ),
      ];

  Future<Either<GetFriendsFailure, List<User>>> execute() async {
    await randomSleep();
    return success(_list);
  }
}
