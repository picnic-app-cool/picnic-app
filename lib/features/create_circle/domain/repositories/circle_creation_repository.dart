import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';
import 'package:picnic_app/features/create_circle/domain/model/create_circle_failure.dart';

abstract class CircleCreationRepository {
  Future<Either<CreateCircleFailure, Circle>> createCircle({
    required CircleInput input,
  });
}
