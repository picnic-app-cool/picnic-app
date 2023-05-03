import 'package:picnic_app/core/domain/model/private_profile.dart';

class EditProfileInitialParams {
  const EditProfileInitialParams({
    this.privateProfile = const PrivateProfile.empty(),
  });

  final PrivateProfile privateProfile;
}
