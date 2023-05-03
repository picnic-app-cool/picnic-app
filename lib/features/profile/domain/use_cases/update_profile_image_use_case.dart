import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/profile/domain/model/update_profile_image_failure.dart';

class UpdateProfileImageUseCase {
  const UpdateProfileImageUseCase(
    this._privateProfileRepository,
    this._userStore,
  );

  final PrivateProfileRepository _privateProfileRepository;
  final UserStore _userStore;

  Future<Either<UpdateProfileImageFailure, ImageUrl>> execute(String filePath) =>
      _privateProfileRepository.updateProfileImage(filePath: filePath).doOn(
            success: (imageUrl) => _userStore.privateProfile = _userStore.privateProfile.copyWith(
              user: _userStore.privateProfile.user.copyWith(profileImageUrl: imageUrl),
            ),
          );
}
