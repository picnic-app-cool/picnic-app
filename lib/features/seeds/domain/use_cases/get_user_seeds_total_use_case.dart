import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/seeds/domain/model/get_user_seeds_total_failure.dart';

class GetUserSeedsTotalUseCase {
  const GetUserSeedsTotalUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<GetUserSeedsTotalFailure, int>> execute() => _seedsRepository.getUserSeedsTotal();
}
