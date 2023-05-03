import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/model/get_seeds_failure.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';

class GetSeedsUseCase {
  const GetSeedsUseCase(this._seedsRepository);

  final SeedsRepository _seedsRepository;

  //TODO: (search query) https://picnic-app.atlassian.net/browse/GS-6875 - add query parameter
  Future<Either<GetSeedsFailure, PaginatedList<Seed>>> execute({
    String searchQuery = '',
    Id? circleId,
    required Cursor nextPageCursor,
  }) =>
      _seedsRepository.getSeeds(nextPageCursor: nextPageCursor, searchQuery: searchQuery).mapSuccess(
            (seeds) => circleId != null ? _circleSpecificSeedHoldings(seeds, circleId) : seeds,
          );

  PaginatedList<Seed> _circleSpecificSeedHoldings(PaginatedList<Seed> seeds, Id circleId) =>
      seeds.byRemovingWhere((seed) => seed.circleId != circleId);
}
