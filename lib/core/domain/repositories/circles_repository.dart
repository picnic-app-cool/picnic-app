import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/circle_stats.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_circle_by_name_failure.dart';
import 'package:picnic_app/core/domain/model/get_circle_stats_failure.dart';
import 'package:picnic_app/core/domain/model/get_circles_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_circles_failure.dart';
import 'package:picnic_app/core/domain/model/group_with_circles.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/domain/model/leave_circle_failure.dart';
import 'package:picnic_app/core/domain/model/onboarding_circles_section.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/update_circle_failure.dart';
import 'package:picnic_app/core/domain/model/update_circle_input.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/invite_users_to_circle_input.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/model/delete_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_banned_users_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_details_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_members_by_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_members_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_roles_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_groups_of_circles_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_onboarding_circles_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_user_roles_in_circle_failure.dart';
import 'package:picnic_app/features/circles/domain/model/invite_user_to_circle_failure.dart';
import 'package:picnic_app/features/circles/domain/model/update_circle_member_role_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/list_groups_input.dart';
import 'package:picnic_app/features/seeds/domain/model/election_candidate.dart';

abstract class CirclesRepository {
  Future<Either<GetCirclesFailure, PaginatedList<Circle>>> getCircles({
    String? searchQuery,
    Cursor? nextPageCursor,
  });

  Future<Either<GetCircleByNameFailure, PaginatedList<Circle>>> getCircle({
    String? searchQuery,
  });

  /// Get circles by user
  /// [userId] - pass null if you want to get current active user circles
  /// [roles] - filter circles by roles
  /// [searchQuery] - filter circles by text
  /// [nextPageCursor] - next page cursor for paging
  Future<Either<GetUserCirclesFailure, PaginatedList<Circle>>> getUserCircles({
    required Cursor nextPageCursor,
    Id? userId,
    List<CircleRole>? roles,
    String? searchQuery,
  });

  Future<Either<JoinCircleFailure, Unit>> joinCircle({required Id circleId});

  Future<Either<JoinCircleFailure, Unit>> joinCircles({required List<Id> circleIds});

  Future<Either<GetCircleDetailsFailure, Circle>> getCircleDetails({required Id circleId});

  Future<Either<LeaveCircleFailure, Unit>> leaveCircle({required Id circleId});

  Future<Either<GetCircleMembersFailure, PaginatedList<PublicProfile>>> getCircleMembers({
    required Id circleId,
    required Cursor cursor,
    required String searchQuery,
  });

  Future<Either<UpdateCircleFailure, Circle>> updateCircle({required UpdateCircleInput input});

  Future<Either<UpdateCircleMemberRoleFailure, Unit>> updateCircleMemberRole({
    required Id circleId,
    required CircleRole role,
    required Id userId,
    required bool isModPermissionEnabled,
  });

  Future<Either<InviteUserToCircleFailure, Circle>> inviteUserToCircle({
    required InviteUsersToCircleInput input,
  });

  Future<Either<GetBannedUsersFailure, PaginatedList<ElectionCandidate>>> getBannedCircleMembers({
    required Id circleId,
    required Cursor cursor,
  });

  Future<Either<GetCircleMembersByRoleFailure, PaginatedList<ElectionCandidate>>> getCircleMembersByRole({
    required Id circleId,
    required Cursor cursor,
    required List<CircleRole> roles,
    required String searchQuery,
  });

  Future<Either<GetGroupsOfCirclesFailure, List<GroupWithCircles>>> getGroupsOfCircles({
    required ListGroupsInput listGroupsInput,
  });

  Future<Either<GetOnBoardingCirclesFailure, List<OnboardingCirclesSection>>> getOnBoardingCircles();

  Future<Either<GetCircleStatsFailure, CircleStats>> getCircleStats({
    required Id circleId,
  });

  Future<Either<GetCircleDetailsFailure, BasicCircle>> getBasicCircle({required Id circleId});

  Future<Either<DeleteRoleFailure, Unit>> deleteCircleRole({
    required Id roleId,
    required Id circleId,
  });

  Future<Either<GetCircleRolesFailure, PaginatedList<CircleCustomRole>>> getCircleRoles({
    required Id circleId,
  });

  Future<Either<GetUserRolesInCircleFailure, CircleMemberCustomRoles>> getUserRolesInCircle({
    required Id circleId,
    required Id userId,
  });
}
