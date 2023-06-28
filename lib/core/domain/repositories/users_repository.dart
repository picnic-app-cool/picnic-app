import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/block_user_failure.dart';
import 'package:picnic_app/core/domain/model/check_username_availability_failure.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/follow_unfollow_user_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_by_username_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_stats_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/search_users_failure.dart';
import 'package:picnic_app/core/domain/model/unblock_user_failure.dart';
import 'package:picnic_app/core/domain/model/user_stats.dart';
import 'package:picnic_app/core/domain/model/username_check_result.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/search_non_member_users_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_followers_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_profile_stats_failure.dart';
import 'package:picnic_app/features/profile/domain/model/send_glitter_bomb_failure.dart';

abstract class UsersRepository {
  Future<Either<CheckUsernameAvailabilityFailure, UsernameCheckResult>> checkUsernameAvailability({
    required String username,
  });

  Future<Either<GetUserFailure, PublicProfile>> getUser({
    required Id userId,
  });

  Future<Either<GetUserStatsFailure, UserStats>> getUserStats({
    required Id userId,
  });

  Future<Either<GetUserByUsernameFailure, Id>> getUserId({
    required String username,
  });

  Future<Either<GetProfileStatsFailure, ProfileStats>> getProfileStats({
    required Id userId,
  });

  Future<Either<GetFollowersFailure, PaginatedList<PublicProfile>>> getFollowers({
    required Id userId,
    required String searchQuery,
    required Cursor nextPageCursor,
  });

  Future<Either<SearchUsersFailure, PaginatedList<PublicProfile>>> searchUser({
    required String searchQuery,
    required Cursor nextPageCursor,
  });

  Future<Either<BlockUserFailure, Unit>> block({
    required Id userId,
  });

  Future<Either<UnblockUserFailure, Unit>> unblock({
    required Id userId,
  });

  Future<Either<FollowUnfollowUserFailure, Unit>> followUnFollowUser({
    required Id userId,
    required bool follow,
  });

  Future<Either<SendGlitterBombFailure, Unit>> sendGlitterBomb({
    required Id userId,
  });

  Future<Either<SearchNonMemberUsersFailure, PaginatedList<PublicProfile>>> searchNonMembershipUsers({
    required String searchQuery,
    required Id circleId,
    required Cursor nextPageCursor,
  });
}
