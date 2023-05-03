import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/profile_meta.dart';

class GqlProfileMeta {
  const GqlProfileMeta({
    required this.pendingSteps,
  });

  factory GqlProfileMeta.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlProfileMeta(
      pendingSteps: asListPrimitive<String>(json, 'pendingSteps').map((e) => ProfileSetupStep.fromString(e)).toList(),
    );
  }

  final List<ProfileSetupStep> pendingSteps;

  ProfileMeta toDomain() => ProfileMeta(
        pendingSteps: pendingSteps,
      );
}
