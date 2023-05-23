import 'package:flutter/widgets.dart';
import 'package:picnic_app/features/chat/circle_chat/widgets/circle_mod_badge.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/achievement_badge_type.dart';

class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    Key? key,
    required this.type,
  }) : super(key: key);

  final AchievementBadgeType type;
  static const double _achievementIconSize = 16;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AchievementBadgeType.verifiedBlue:
        return Image.asset(
          Assets.images.verificationBadgePink.path,
          height: _achievementIconSize,
          width: _achievementIconSize,
        );
      case AchievementBadgeType.verifiedWhite:
        return Image.asset(
          Assets.images.achievementBadgeWhite.path,
          height: _achievementIconSize,
          width: _achievementIconSize,
        );
      case AchievementBadgeType.moderator:
        return const CircleModBadge();
    }
  }
}
