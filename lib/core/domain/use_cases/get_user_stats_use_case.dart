import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_user_stats_failure.dart';
import 'package:picnic_app/core/domain/model/user_stats.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GetUserStatsUseCase {
  const GetUserStatsUseCase(
    this._usersRepository,
  );

  final UsersRepository _usersRepository;

  Future<Either<GetUserStatsFailure, UserStats>> execute({
    required Id userId,
  }) =>
      _usersRepository.getUserStats(userId: userId);
}
