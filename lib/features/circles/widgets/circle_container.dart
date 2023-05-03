import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_stats.dart';
import 'package:picnic_app/core/domain/model/picnic_stat.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/circles/circle_details/widgets/circle_details_buttons.dart';
import 'package:picnic_app/features/create_circle/create_circle/widgets/circle_cover_header.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_stats.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    super.key,
    required this.circle,
    this.picnicStats,
    this.slicesCount,
    required this.seedsCount,
    this.circleButtons,
    required this.onTapStat,
    this.isLoadingStats = false,
    required this.circleStats,
    required this.onTapSeeds,
    required this.onTapElection,
    required this.onCoverVisibilityAppear,
    required this.onCoverVisibilityDisappear,
  });

  final Circle circle;
  final PicnicStats? picnicStats;
  final CircleDetailsButtons? circleButtons;
  final int? slicesCount;
  final int seedsCount;
  final Function(StatType) onTapStat;
  final VoidCallback onTapSeeds;
  final VoidCallback onTapElection;
  final VoidCallback onCoverVisibilityAppear;
  final VoidCallback onCoverVisibilityDisappear;

  final bool isLoadingStats;
  final CircleStats circleStats;

  static const _borderRadius = 100.0;
  static const _blurRadius = 30.0;
  static const _iconSize = 18.0;
  static const _boxShadowOpacity = 0.07;
  static const _contentHorizontalPadding = 16.0;

  static const _tagPadding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    final picnicStats = PicnicStats(
      onTap: onTapStat,
      isLoading: isLoadingStats,
      stats: [
        PicnicStat(
          type: StatType.posts,
          count: circleStats.postsCount,
        ),
        PicnicStat(
          type: StatType.views,
          count: circleStats.viewsCount,
        ),
        PicnicStat(
          type: StatType.members,
          count: circle.membersCount,
        ),
      ],
    );

    final _tagOpacity = colors.blackAndWhite.shade900.withOpacity(_boxShadowOpacity);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewInForegroundDetector(
          viewDidAppear: onCoverVisibilityAppear,
          viewDidDisappear: onCoverVisibilityDisappear,
          child: CircleCoverHeader(
            emoji: circle.emoji,
            image: circle.imageFile,
            userSelectedNewImage: false,
            coverImage: circle.coverImage,
            userSelectedNewCoverImage: false,
            contentPadding: _contentHorizontalPadding,
            trailingWidget: Row(
              children: [
                InkWell(
                  onTap: onTapElection,
                  child: Container(
                    padding: _tagPadding,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: _blurRadius,
                          color: _tagOpacity,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      color: colors.blackAndWhite.shade100,
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                    child: Row(
                      children: [
                        Assets.images.election.image(width: _iconSize),
                        const Gap(4),
                        Text(
                          appLocalizations.circleElectionDirectorElection,
                          style: styles.body20,
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                InkWell(
                  onTap: onTapSeeds,
                  child: Container(
                    padding: _tagPadding,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: _blurRadius,
                          color: _tagOpacity,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                    child: Row(
                      children: [
                        Assets.images.acorn.image(width: _iconSize),
                        const Gap(4),
                        Text(
                          seedsCount.formattingToStat(),
                          style: styles.body20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _contentHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                circle.name,
                style: styles.title30,
                textAlign: TextAlign.start,
              ),
              const Gap(8),
              Text(
                circle.description,
                style: styles.body20.copyWith(color: colors.blackAndWhite.shade600),
                textAlign: TextAlign.start,
              ),
              const Gap(8),
              if (circleButtons != null) circleButtons!,
              const Gap(8),
              picnicStats,
            ],
          ),
        ),
      ],
    );
  }
}
