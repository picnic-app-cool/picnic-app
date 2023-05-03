import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/features/profile/domain/model/get_private_profile_failure.dart';

class GetPrivateProfileUseCase {
  const GetPrivateProfileUseCase(this._privateProfileRepository);

  final PrivateProfileRepository _privateProfileRepository;

  Future<Either<GetPrivateProfileFailure, PrivateProfile>> execute() => _privateProfileRepository.getPrivateProfile();
}
