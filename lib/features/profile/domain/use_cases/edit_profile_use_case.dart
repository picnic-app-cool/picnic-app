import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/profile/domain/model/edit_profile_failure.dart';

class EditProfileUseCase {
  const EditProfileUseCase(
    this._privateProfileRepository,
    this._userStore,
  );

  final PrivateProfileRepository _privateProfileRepository;
  final UserStore _userStore;

  Future<Either<EditProfileFailure, Unit>> execute({
    String? username,
    String? fullName,
    String? bio,
    int? age,
  }) =>
      _privateProfileRepository
          .editPrivateProfile(
            username: username,
            fullName: fullName,
            bio: bio,
            age: age,
          )
          .doOn(
            success: (_) => _userStore.privateProfile = _userStore.privateProfile.copyWith(
              age: age,
              user: _userStore.privateProfile.user.copyWith(
                bio: bio,
                username: username,
                fullName: fullName,
              ),
            ),
          );
}
