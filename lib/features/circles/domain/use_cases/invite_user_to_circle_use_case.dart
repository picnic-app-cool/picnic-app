import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/invite_users_to_circle_input.dart';
import 'package:picnic_app/features/circles/domain/model/invite_user_to_circle_failure.dart';

class InviteUserToCircleUseCase {
  const InviteUserToCircleUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<InviteUserToCircleFailure, Circle>> execute({required InviteUsersToCircleInput input}) async {
    return _circlesRepository.inviteUserToCircle(input: input);
  }
}
