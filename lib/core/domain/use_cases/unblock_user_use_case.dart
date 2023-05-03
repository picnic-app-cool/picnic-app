import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/unblock_user_failure.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class UnblockUserUseCase {
  const UnblockUserUseCase(this._usersRepository);

  final UsersRepository _usersRepository;

  Future<Either<UnblockUserFailure, Unit>> execute({required Id userId}) async {
    return _usersRepository.unblock(userId: userId);
  }
}
