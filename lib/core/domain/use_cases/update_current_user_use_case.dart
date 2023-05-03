import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/update_current_user_failure.dart';
import 'package:picnic_app/core/domain/repositories/local_storage_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class UpdateCurrentUserUseCase {
  const UpdateCurrentUserUseCase(this._localStorageRepository);

  final LocalStorageRepository _localStorageRepository;

  Future<Either<UpdateCurrentUserFailure, Unit>> execute(
    PrivateProfile user,
  ) async {
    return _localStorageRepository
        .saveCurrentUser(user: user)
        .mapFailure((fail) => UpdateCurrentUserFailure.unknown(fail));
  }
}
