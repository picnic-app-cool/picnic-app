// ignore_for_file: unused-code, unused-files

import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class Stubs {
  static PrivateProfile get privateProfile => const PrivateProfile.empty().copyWith(user: user, languages: ['en']);

  static User get user => const User.empty().copyWith(
        id: const Id('user-id-payamdaliri'),
        username: 'payamdaliri',
        profileImageUrl: const ImageUrl('https://example.com/image.jpg'),
        isVerified: false,
      );
}
