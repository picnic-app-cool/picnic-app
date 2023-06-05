import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/private_profile/widgets/profile_horizontal_item.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/widgets/seed_list_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class SeedsTab extends StatelessWidget {
  const SeedsTab({
    required this.seedsList,
    required this.onLoadMore,
    required this.onTapSendSeeds,
    required this.onTapCircle,
    required this.onTapSeedsInfo,
    required this.totalSeeds,
  });

  final PaginatedList<Seed> seedsList;
  final Future<void> Function() onLoadMore;
  final VoidCallback onTapSendSeeds;
  final VoidCallback onTapSeedsInfo;
  final Function(Id) onTapCircle;
  final String totalSeeds;

  static const _acornSize = 20.0;
  static const _acornSizeTotalSeeds = 26.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final darkBlue = theme.colors.darkBlue;
    const arrowSize = 16.0;
    const separatorWidth = 2.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              appLocalizations.mySeeds,
              style: styles.title50.copyWith(color: darkBlue.shade800),
            ),
            const Gap(4),
            GestureDetector(
              onTap: onTapSeedsInfo,
              child: Image.asset(
                Assets.images.infoOutlined.path,
                color: darkBlue.shade800,
              ),
            ),
          ],
        ),
        const Gap(16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PicnicImage(
              source: PicnicImageSource.asset(
                ImageUrl(Assets.images.acorn.path),
                height: _acornSizeTotalSeeds,
                width: _acornSizeTotalSeeds,
              ),
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    totalSeeds,
                    style: theme.styles.link40.copyWith(color: darkBlue.shade800),
                  ),
                  Text(
                    appLocalizations.totalSeeds,
                    style: theme.styles.body20.copyWith(color: darkBlue.shade600),
                  ),
                  const Gap(12),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: separatorWidth,
          width: double.infinity,
          color: darkBlue.shade300,
        ),
        const Gap(16),
        ProfileHorizontalItem(
          onTap: onTapSendSeeds,
          title: appLocalizations.sendSeedsAction,
          trailing: Icon(
            Icons.arrow_forward,
            color: darkBlue.shade800,
            size: arrowSize,
          ),
        ),
        const Gap(16),
        Expanded(
          child: PicnicPagingListView<Seed>(
            paginatedList: seedsList,
            loadMore: onLoadMore,
            loadingBuilder: (_) => const PicnicLoadingIndicator(),
            separatorBuilder: (_, __) => const Gap(8),
            itemBuilder: (context, seed) {
              final trailing = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PicnicImage(
                    source: PicnicImageSource.asset(
                      ImageUrl(Assets.images.acorn.path),
                      height: _acornSize,
                      width: _acornSize,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    seed.amountTotal.formattingToStat(),
                    style: styles.link20.copyWith(color: theme.colors.blackAndWhite.shade900),
                  ),
                ],
              );
              final membersCount = seed.circle.membersCount;
              final membersCountFormatted = appLocalizations.membersCount(membersCount).replaceAll(
                    membersCount.toString(),
                    membersCount.formattingToStat(),
                  );
              return SeedListItem(
                seed: seed,
                title: seed.circleName,
                trailing: trailing,
                subTitle: membersCountFormatted,
                onTapOpenCircle: () => onTapCircle(seed.circleId),
              );
            },
          ),
        ),
      ],
    );
  }
}
