//Figma Link :
//https://www.figma.com/file/6jHfRx6qqnUyQ25IWCziNK/Picnic-Redesign?node-id=4%3A623

import 'package:picnic_app/core/domain/model/picnic_stat.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/ui/widgets/picnic_stats.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicUserProfileStatsUseCase extends WidgetbookComponent {
  PicnicUserProfileStatsUseCase()
      : super(
          name: "$PicnicStats",
          useCases: [
            WidgetbookUseCase(
              name: "User Profile Stats Use Cases",
              builder: (context) => PicnicStats(
                onTap: (_) => notImplemented(),
                stats: const [
                  PicnicStat(
                    type: StatType.likes,
                    count: 42000,
                  ),
                  PicnicStat(
                    type: StatType.followers,
                    count: 152300,
                  ),
                  PicnicStat(
                    type: StatType.views,
                    count: 44561,
                  ),
                ],
              ),
            ),
          ],
        );
}
