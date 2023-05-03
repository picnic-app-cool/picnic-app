import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/add_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/model/assign_user_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/ban_user_failure.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_input.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_update_input.dart';
import 'package:picnic_app/features/circles/domain/model/create_circle_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_default_circle_config_failure.dart';
import 'package:picnic_app/features/circles/domain/model/remove_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/model/un_assign_user_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/unban_user_failure.dart';
import 'package:picnic_app/features/circles/domain/model/update_circle_role_failure.dart';

abstract class CircleModeratorActionsRepository {
  Future<Either<BanUserFailure, Id>> banUser({
    required Id circleId,
    required Id userId,
  });

  Future<Either<UnbanUserFailure, Id>> unbanUser({
    required Id circleId,
    required Id userId,
  });

  Future<Either<GetBlacklistedWordsFailure, PaginatedList<String>>> getBlackListedWords({
    required Id circleId,
    required Cursor cursor,
    String? searchQuery,
  });

  Future<Either<AddBlacklistedWordsFailure, Unit>> addBlackListedWords({
    required Id circleId,
    required List<String> words,
  });

  Future<Either<RemoveBlacklistedWordsFailure, Unit>> removeBlacklistedWords({
    required Id circleId,
    required List<String> words,
  });

  Future<Either<CreateCircleRoleFailure, Id>> createCircleRole({
    required CircleCustomRoleInput circleCustomRoleInput,
  });

  Future<Either<UpdateCircleRoleFailure, Id>> updateCircleRole({
    required CircleCustomRoleUpdateInput circleCustomRoleUpdateInput,
  });

  Future<Either<AssignUserRoleFailure, Unit>> assignRole({
    required Id circleId,
    required Id userId,
    required Id roleId,
  });

  Future<Either<UnAssignUserRoleFailure, Unit>> unAssignRole({
    required Id circleId,
    required Id userId,
    required Id roleId,
  });

  Future<Either<GetDefaultCircleConfigFailure, List<CircleConfig>>> getDefaultCircleConfig();
}
