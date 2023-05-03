import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/discover/domain/model/circle_group.dart';
import 'package:picnic_app/features/discover/domain/model/discover_failure.dart';

abstract class DiscoverRepository {
  Future<Either<DiscoverFailure, List<CircleGroup>>> getGroups();
}
