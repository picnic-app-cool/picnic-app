import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/pods/widgets/pod_tags_horizontal_list.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class DetailedPodWidget extends StatelessWidget {
  const DetailedPodWidget({
    Key? key,
    required this.pod,
    required this.onTapShare,
    required this.onTapView,
    required this.onTapAddToCircle,
  }) : super(key: key);

  final PodApp pod;
  final VoidCallback onTapShare;
  final VoidCallback onTapView;
  final VoidCallback onTapAddToCircle;

  static const radius = 16.0;
  static const double _avatarSize = 40;
  static const double _borderWidth = 0.5;
  static const double _buttonsHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;
    final body20 = theme.styles.body20;
    final darkBlue = themeColors.darkBlue;
    final blackAndWhite = themeColors.blackAndWhite;
    final darkBlueShade700 = darkBlue.shade700;
    final darkBlueShade300 = darkBlue.shade300;
    final link15style = theme.styles.link15;

    return GestureDetector(
      onTap: onTapView,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: blackAndWhite.shade100,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: blackAndWhite.shade300,
                width: _borderWidth,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
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
                              style: theme.styles.title50.copyWith(color: themeColors.blackAndWhite.shade900),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              pod.owner.name,
                              style: body20.copyWith(color: darkBlue.shade600),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Assets.images.arrowUp.image(),
                          const Gap(8),
                          Text(
                            pod.counters.upvotes.formattingToStat(),
                            style: body20.copyWith(color: darkBlue),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(14),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          pod.description,
                          style: body20.copyWith(color: darkBlueShade700),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Gap(14),
                  PodTagsHorizontalList(
                    tags: pod.appTags,
                  ),
                  const Gap(14),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: _buttonsHeight,
                          child: PicnicButton(
                            padding: EdgeInsets.zero,
                            title: appLocalizations.view,
                            onTap: onTapView,
                            titleStyle: link15style.copyWith(color: darkBlue.shade800),
                            color: darkBlueShade300,
                          ),
                        ),
                      ),
                      const Gap(6),
                      Expanded(
                        child: PicnicButton(
                          title: appLocalizations.addToCircle,
                          titleColor: Colors.white,
                          onTap: onTapAddToCircle,
                          color: theme.colors.blue.shade500,
                          minWidth: double.infinity,
                        ),
                      ),
                      const Gap(6),
                      GestureDetector(
                        onTap: onTapShare,
                        child: Container(
                          width: _buttonsHeight,
                          height: _buttonsHeight,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: darkBlueShade300,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              Assets.images.uploadOutlined.path,
                              color: darkBlue.shade800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
