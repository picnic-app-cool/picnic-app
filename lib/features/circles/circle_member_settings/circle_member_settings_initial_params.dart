import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';

class CircleMemberSettingsInitialParams {
  const CircleMemberSettingsInitialParams({
    required this.user,
    required this.circle,
  });

  final PublicProfile user;
  final Circle circle;
}
