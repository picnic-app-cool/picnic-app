import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/paging_list/paging_grid_view.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PreviewPodTabWidget extends StatelessWidget {
  const PreviewPodTabWidget({
    required this.title,
    required this.description,
    required this.circles,
    required this.onTapCircle,
    required this.onLoadMore,
  });

  final String title;
  final String description;
  final PaginatedList<Circle> circles;
  final Function(Circle) onTapCircle;
  final Future<void> Function() onLoadMore;

  static const _descriptionContainerRadius = 16.0;
  static const _columns = 3;
  static const _spacing = 8.0;
  static const _circleBorderRadius = 12.0;
  static const _circleBorderWidth = 1.5;
  static const _circleAvatarSize = 40.0;
  static const _emojiSize = 20.0;
  static const _circleAspectRatio = 0.9;
  static const _descriptionMaxNumberOfLines = 2;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final darkBlue = colors.darkBlue;
    final darkBlueShade600 = darkBlue.shade600;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_descriptionContainerRadius),
              color: darkBlue.shade300,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.styles.link30.copyWith(color: darkBlue.shade800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(6),
                  Text(
                    description,
                    maxLines: _descriptionMaxNumberOfLines,
                    style: theme.styles.body20.copyWith(color: darkBlueShade600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const Gap(20),
          Expanded(
            child: PagingGridView<Circle>(
              paging: circles,
              columns: _columns,
              aspectRatio: _circleAspectRatio,
              loadMore: onLoadMore,
              mainAxisSpacing: _spacing,
              crossAxisSpacing: _spacing,
              loadingBuilder: (_) => const Center(
                child: PicnicLoadingIndicator(),
              ),
              itemBuilder: (context, index) {
                final circle = circles.items[index];
                return GestureDetector(
                  onTap: () => onTapCircle(circle),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_circleBorderRadius),
                      border: Border.all(
                        width: _circleBorderWidth,
                        color: darkBlue.shade400,
                      ),
                      color: colors.blackAndWhite.shade100,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const Spacer(),
                          PicnicCircleAvatar(
                            emoji: circle.emoji,
                            image: circle.imageFile,
                            emojiSize: _emojiSize,
                            avatarSize: _circleAvatarSize,
                            bgColor: theme.colors.blue.shade200,
                          ),
                          const Spacer(),
                          Text(
                            circle.name,
                            style: theme.styles.link20.copyWith(color: colors.blackAndWhite.shade900),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Assets.images.community.image(
                                color: darkBlueShade600,
                              ),
                              const Gap(8),
                              Text(
                                circle.membersCount.formattingToStat(),
                                style: theme.styles.subtitle10.copyWith(color: darkBlueShade600),
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
