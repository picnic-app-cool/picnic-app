import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/achievement_badge_type.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';

class BadgedTitleDisplayable extends Equatable {
  const BadgedTitleDisplayable({
    required this.name,
    this.badges = const [],
  });

  const BadgedTitleDisplayable.empty()
      : name = '',
        badges = const [];

  final String name;
  final List<AchievementBadgeType> badges;

  @override
  List<Object?> get props => [
        name,
        badges,
      ];

  BadgedTitleDisplayable byAddingBadge(AchievementBadgeType type) => copyWith(badges: badges + [type]);

  BadgedTitleDisplayable byAddingBadges(List<AchievementBadgeType> types) => copyWith(badges: badges + types);

  BadgedTitleDisplayable copyWith({
    String? name,
    List<AchievementBadgeType>? badges,
  }) {
    return BadgedTitleDisplayable(
      name: name ?? this.name,
      badges: badges ?? this.badges,
    );
  }
}

extension UserToBadgedTitleDisplayableMapper on User {
  BadgedTitleDisplayable toBadgedAuthorDisplayable({bool formatName = true}) {
    return BadgedTitleDisplayable(
      name: formatName ? username.formattedUsername : username,
      badges: [
        if (isVerified) AchievementBadgeType.verifiedRed,
      ],
    );
  }
}
