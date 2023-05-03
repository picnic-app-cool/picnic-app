import 'package:flutter/widgets.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/achievement_badge.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/badged_title_displayable.dart';

class BadgedTitle extends StatelessWidget {
  const BadgedTitle({
    Key? key,
    required this.model,
    required this.style,
  }) : super(key: key);

  final BadgedTitleDisplayable model;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: model.badges.fold<List<Widget>>(
        [
          Flexible(
            child: Text(
              model.name,
              style: style,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        (previousValue, badgeType) {
          return previousValue +
              [
                const SizedBox(
                  width: 4,
                  height: 0,
                ),
                AchievementBadge(type: badgeType),
              ];
        },
      ),
    );
  }
}
