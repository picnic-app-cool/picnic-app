import 'package:picnic_app/localization/app_localizations_utils.dart';

enum SliceRole {
  none(value: 'NONE'),
  owner(value: 'OWNER'),
  pending(value: 'PENDING'),
  director(value: 'DIRECTOR'),
  moderator(value: 'MODERATOR'),
  member(value: 'MEMBER');

  final String value;

  String get valueToDisplay {
    switch (this) {
      case SliceRole.none:
        return appLocalizations.none;
      case SliceRole.owner:
        return appLocalizations.owner;
      case SliceRole.pending:
        return appLocalizations.pending;
      case SliceRole.member:
        return appLocalizations.circleRoleMember;
      case SliceRole.director:
        return appLocalizations.circleRoleDirector;
      case SliceRole.moderator:
        return appLocalizations.circleRoleModerator;
    }
  }

  const SliceRole({required this.value});

  static List<SliceRole> get allRoles => [
        owner,
        member,
        pending,
      ];

  static SliceRole fromString(String value) => SliceRole.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => SliceRole.none,
      );

  String toJson() {
    return value;
  }
}
