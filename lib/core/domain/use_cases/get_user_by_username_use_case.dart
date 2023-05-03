import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_user_by_username_failure.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GetUserByUsernameUseCase {
  const GetUserByUsernameUseCase(
    this._usersRepository,
  );

  final UsersRepository _usersRepository;

  Future<Either<GetUserByUsernameFailure, Id>> execute({
    required String username,
  }) =>
      _usersRepository.getUserId(username: username);
}
