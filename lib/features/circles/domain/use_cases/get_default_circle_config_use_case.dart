import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/features/circles/domain/model/get_default_circle_config_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';

class GetDefaultCircleConfigUseCase {
  const GetDefaultCircleConfigUseCase(this._circleModeratorActionsRepository);

  final CircleModeratorActionsRepository _circleModeratorActionsRepository;

  Future<Either<GetDefaultCircleConfigFailure, List<CircleConfig>>> execute() =>
      _circleModeratorActionsRepository.getDefaultCircleConfig();
}
