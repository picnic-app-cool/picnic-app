import 'package:picnic_app/localization/app_localizations_utils.dart';

enum CircleRole {
  none(value: 'NONE'),
  member(value: 'MEMBER'),
  moderator(value: 'MODERATOR'),
  director(value: 'DIRECTOR');

  final String value;

  String get valueToDisplay {
    switch (this) {
      case CircleRole.none:
        return appLocalizations.none;
      case CircleRole.member:
        return appLocalizations.circleRoleMember;
      case CircleRole.moderator:
        return appLocalizations.circleRoleModerator;
      case CircleRole.director:
        return appLocalizations.circleRoleDirector;
    }
  }

  const CircleRole({required this.value});

  static List<CircleRole> get allRoles => [
        member,
        moderator,
        director,
      ];

  static CircleRole fromString(String value) => CircleRole.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => CircleRole.none,
      );

  String toJson() {
    return value;
  }
}
