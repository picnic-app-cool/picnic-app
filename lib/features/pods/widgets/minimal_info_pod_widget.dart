import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/pods/widgets/pod_tags_horizontal_list.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class MinimalInfoPodWidget extends StatelessWidget {
  const MinimalInfoPodWidget({
    Key? key,
    required this.pod,
    required this.onTapPod,
  }) : super(key: key);

  final PodApp pod;
  final Function(PodApp) onTapPod;

  static const radius = 16.0;
  static const double _avatarSize = 56;
  static const double _upvotesCommunityIconsSize = 13;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;
    final body10 = theme.styles.body10;
    final statsStyle = body10.copyWith(color: themeColors.darkBlue);
    return GestureDetector(
      onTap: () => onTapPod(pod),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  PicnicAvatar(
                    key: UniqueKey(),
                    size: _avatarSize,
                    boxFit: PicnicAvatarChildBoxFit.cover,
                    imageSource: PicnicImageSource.url(
                      ImageUrl(pod.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    placeholder: () => DefaultAvatar.user(),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pod.name,
                          style: theme.styles.title40.copyWith(color: themeColors.blackAndWhite.shade900),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(6),
                        Row(
                          children: [
                            Assets.images.arrowUp.image(height: _upvotesCommunityIconsSize),
                            const Gap(6),
                            Text(
                              pod.counters.upvotes.formattingToStat(),
                              style: statsStyle,
                            ),
                            const Gap(16),
                            Assets.images.community.image(height: _upvotesCommunityIconsSize),
                            const Gap(6),
                            Text(
                              pod.counters.circles.formattingToStat(),
                              style: statsStyle,
                            ),
                          ],
                        ),
                        const Gap(6),
                        PodTagsHorizontalList(
                          tags: pod.appTags,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
