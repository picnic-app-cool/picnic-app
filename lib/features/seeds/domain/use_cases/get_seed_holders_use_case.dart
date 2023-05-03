import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/get_seedholders_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/seed_holder.dart';

class GetSeedHoldersUseCase {
  const GetSeedHoldersUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  Future<Either<GetSeedHoldersFailure, PaginatedList<SeedHolder>>> execute({required Id circleId}) async {
    return _seedsRepository.getSeedHolders(circleId: circleId);
  }
}
