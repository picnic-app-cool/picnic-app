import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/leave_circle_failure.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/core/domain/stores/user_circles_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class LeaveCircleUseCase {
  const LeaveCircleUseCase(
    this._circlesRepository,
    this._userCirclesStore,
  );

  final CirclesRepository _circlesRepository;
  final UserCirclesStore _userCirclesStore;

  Future<Either<LeaveCircleFailure, Unit>> execute({
    required BasicCircle circle,
  }) async {
    return _circlesRepository.leaveCircle(circleId: circle.id).doOn(
          success: (_) => _userCirclesStore.removeCircle(circle),
        );
  }
}
