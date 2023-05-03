import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_user_failure.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GetUserUseCase {
  const GetUserUseCase(
    this._usersRepository,
  );

  final UsersRepository _usersRepository;

  Future<Either<GetUserFailure, PublicProfile>> execute({
    required Id userId,
  }) =>
      _usersRepository.getUser(userId: userId);
}
