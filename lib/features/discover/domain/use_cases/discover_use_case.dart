import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/discover/domain/model/circle_group.dart';
import 'package:picnic_app/features/discover/domain/model/discover_failure.dart';
import 'package:picnic_app/features/discover/domain/repositories/discover_repository.dart';

class DiscoverUseCase {
  DiscoverUseCase(this._discoverRepository);

  final DiscoverRepository _discoverRepository;

  Future<Either<DiscoverFailure, List<CircleGroup>>> execute() => _discoverRepository.getGroups();
}
