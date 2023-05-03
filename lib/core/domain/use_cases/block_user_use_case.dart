import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/block_user_failure.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class BlockUserUseCase {
  const BlockUserUseCase(this._usersRepository);

  final UsersRepository _usersRepository;

  Future<Either<BlockUserFailure, Unit>> execute({required Id userId}) async {
    return _usersRepository.block(
      userId: userId,
    );
  }
}
