import 'package:picnic_app/core/data/graphql/model/gql_profile_meta.dart';
import 'package:picnic_app/core/data/graphql/model/gql_user.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';

class GqlPrivateProfile {
  const GqlPrivateProfile({
    required this.user,
    required this.email,
    required this.languages,
    required this.melonsAmount,
    required this.seedsAmount,
    required this.age,
    required this.meta,
  });

  factory GqlPrivateProfile.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlPrivateProfile(
      user: GqlUser.fromJson(json),
      email: asT<String>(json, 'email'),
      languages: asListPrimitive<String>(json, 'languages'),
      melonsAmount: asT<int>(json, 'melonsAmount'),
      seedsAmount: asT<int>(json, 'seedsAmount'),
      age: asT<int>(json, 'age'),
      meta: GqlProfileMeta.fromJson((json['meta'] as Map?)?.cast() ?? {}),
    );
  }

  final GqlUser user;

  final String email;

  final List<String> languages;
  final int melonsAmount;
  final int seedsAmount;
  final int age;

  final GqlProfileMeta meta;

  PrivateProfile toDomain() => PrivateProfile(
        user: user.toDomain(),
        email: email,
        melonsAmount: melonsAmount,
        seedsAmount: seedsAmount,
        age: age,
        languages: languages,
        meta: meta.toDomain(),
      );
}
