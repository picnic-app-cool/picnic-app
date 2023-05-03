import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/model/send_glitter_bomb_failure.dart';

class SendGlitterBombUseCase {
  const SendGlitterBombUseCase(
    this._usersRepository,
  );

  final UsersRepository _usersRepository;

  Future<Either<SendGlitterBombFailure, Unit>> execute(Id userId) => _usersRepository.sendGlitterBomb(userId: userId);
}
