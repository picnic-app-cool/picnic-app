import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/model/get_profile_stats_failure.dart';

class GetProfileStatsUseCase {
  const GetProfileStatsUseCase(
    this._usersRepository,
  );

  final UsersRepository _usersRepository;

  Future<Either<GetProfileStatsFailure, ProfileStats>> execute({
    required Id userId,
  }) =>
      _usersRepository.getProfileStats(userId: userId);
}
