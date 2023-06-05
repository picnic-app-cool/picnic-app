import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class Pod extends StatelessWidget {
  const Pod({
    Key? key,
    required this.pod,
    required this.onTapAddCircle,
    required this.onTapSave,
    required this.onTapView,
    required this.width,
    required this.height,
  }) : super(key: key);

  final PodApp pod;
  final VoidCallback onTapAddCircle;
  final VoidCallback onTapSave;
  final VoidCallback onTapView;

  final double width;
  final double height;
  static const tagHeight = 30.0;

  static const radius = 16.0;
  static const double _avatarSize = 40;
  static const double _borderWidth = 0.5;
  static const double _tagsBorderRadius = 8.0;
  static const double _buttonsHeight = 42.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;

    final body20 = theme.styles.body20;
    final blackAndWhite = themeColors.blackAndWhite;
    final darkBlueShade700 = themeColors.darkBlue.shade700;

    const saveIconHeight = 14.0;
    const saveIconWidth = 10.0;

    final sub20 = theme.styles.subtitle20.copyWith(color: darkBlueShade700);
    final tagsRow = SizedBox(
      height: tagHeight,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: pod.appTags.length,
        separatorBuilder: (context, index) => const Gap(8),
        itemBuilder: (BuildContext context, int index) {
          final tag = pod.appTags[index];
          return PicnicTag(
            opacity: 1.0,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            titleHeight: 1.0,
            title: tag.name,
            borderRadius: _tagsBorderRadius,
            backgroundColor: themeColors.darkBlue.shade300,
            titleTextStyle: theme.styles.body10.copyWith(color: themeColors.darkBlue.shade800),
          );
        },
      ),
    );
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
            width: width,
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
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pod.name,
                              style: body20,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              pod.owner.name,
                              style: theme.styles.subtitle10.copyWith(color: themeColors.darkBlue.shade600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  Row(
                    children: [
                      const Gap(12),
                      Assets.images.arrowUp.image(),
                      const Gap(8),
                      Text(
                        pod.counters.upvotes.formattingToStat(),
                        style: sub20,
                      ),
                      const Gap(40),
                      Assets.images.community.image(),
                      const Gap(8),
                      Text(
                        pod.counters.circles.formattingToStat(),
                        style: sub20,
                      ),
                    ],
                  ),
                  const Gap(12),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          pod.description,
                          style: theme.styles.body0.copyWith(color: darkBlueShade700),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  tagsRow,
                  const Gap(12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: _buttonsHeight,
                          height: _buttonsHeight,
                          child: PicnicButton(
                            padding: EdgeInsets.zero,
                            title: appLocalizations.launchAction,
                            onTap: onTapAddCircle,
                            titleStyle: theme.styles.title10.copyWith(color: blackAndWhite.shade100),
                            minWidth: double.infinity,
                            color: theme.colors.purple.shade500,
                          ),
                        ),
                      ),
                      const Gap(6),
                      InkWell(
                        onTap: onTapSave,
                        child: Container(
                          width: _buttonsHeight,
                          height: _buttonsHeight,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: themeColors.darkBlue.shade300,
                          ),
                          child: Image.asset(
                            pod.iSaved ? Assets.images.saveFilled.path : Assets.images.saveOutlined.path,
                            color: darkBlueShade700,
                            height: saveIconHeight,
                            width: saveIconWidth,
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
