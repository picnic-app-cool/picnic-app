import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/check_username_availability_failure.dart';
import 'package:picnic_app/core/domain/model/username_check_result.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';

class CheckUsernameAvailabilityUseCase {
  const CheckUsernameAvailabilityUseCase(
    this._usersRepository,
  );

  final UsersRepository _usersRepository;

  Future<Either<CheckUsernameAvailabilityFailure, UsernameCheckResult>> execute({
    required String username,
  }) async =>
      _usersRepository.checkUsernameAvailability(username: username);
}
