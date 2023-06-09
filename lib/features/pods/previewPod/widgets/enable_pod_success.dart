import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class EnablePodSuccess extends StatelessWidget {
  const EnablePodSuccess({
    required this.pod,
    required this.circle,
    required this.onTapLaunch,
  });

  final PodApp pod;
  final Circle circle;
  final VoidCallback onTapLaunch;

  static const circlePodImageSize = 80.0;
  static const bottomSheetTopDividerHeight = 6.0;
  static const bottomSheetTopDividerWidth = 40.0;
  static const bottomSheetTopDividerRadius = 100.0;
  static const circleEmojiSize = 40.0;
  static const _heightFactor = 0.45;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    return FractionallySizedBox(
      heightFactor: _heightFactor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Center(
              child: Container(
                height: bottomSheetTopDividerHeight,
                width: bottomSheetTopDividerWidth,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(bottomSheetTopDividerRadius)),
                  color: colors.darkBlue.shade300,
                ),
              ),
            ),
            const Gap(16),
            Row(
              children: [
                PicnicAvatar(
                  size: circlePodImageSize,
                  boxFit: PicnicAvatarChildBoxFit.cover,
                  imageSource: PicnicImageSource.url(
                    ImageUrl(pod.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          width: double.infinity,
                          Assets.images.interruptedLine.path,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          Assets.images.roundedGreenCheck.path,
                        ),
                      ),
                    ],
                  ),
                ),
                PicnicCircleAvatar(
                  emoji: circle.emoji,
                  image: circle.imageFile,
                  emojiSize: circleEmojiSize,
                  avatarSize: circlePodImageSize,
                  bgColor: theme.colors.blue.shade200,
                ),
              ],
            ),
            const Gap(16),
            Text(
              appLocalizations.congratulations,
              style: theme.styles.link30.copyWith(color: colors.darkBlue.shade800),
            ),
            const Gap(6),
            Text(
              appLocalizations.podAddedToCircle(pod.name, circle.name),
              style: theme.styles.body20.copyWith(color: colors.darkBlue.shade600),
            ),
            const Gap(16),
            PicnicButton(
              title: appLocalizations.launchAction,
              titleColor: Colors.white,
              onTap: onTapLaunch,
              color: colors.purple,
              icon: Assets.images.podRobot.path,
              minWidth: double.infinity,
            ),
            const Gap(16),
            Center(
              child: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Text(
                  appLocalizations.cancelAction,
                  style: theme.styles.subtitle15.copyWith(color: colors.darkBlue.shade700),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
