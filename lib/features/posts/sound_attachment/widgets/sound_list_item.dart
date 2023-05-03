import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/playable_sound.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SoundListItem extends StatefulWidget {
  const SoundListItem({
    required this.playableSound,
    required this.onTapPlayPause,
    required this.onTapSelect,
    Key? key,
  }) : super(key: key);

  final PlayableSound playableSound;
  final VoidCallback onTapPlayPause;
  final VoidCallback onTapSelect;

  Sound get sound => playableSound.sound;

  bool get isPlaying => playableSound.isPlaying;

  @override
  State<SoundListItem> createState() => _SoundListItemState();
}

class _SoundListItemState extends State<SoundListItem> {
  static const _imageSize = Size(60.0, 60.0);
  static const _playAnimationSize = Size(16.0, 16.0);
  static const _playAnimationPadding = 4.0;
  static const _elementsPadding = 8.0;
  static const _usesCountPadding = 2.0;
  static const _padding = EdgeInsets.fromLTRB(
    Constants.largePadding,
    0.0,
    Constants.largePadding,
    _elementsPadding,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final black600 = colors.blackAndWhite.shade600;
    final nameStyle = theme.styles.body30.copyWith(color: colors.blackAndWhite.shade700);
    final artistStyle = theme.styles.caption20.copyWith(color: black600);
    final durationStyle = theme.styles.body0.copyWith(color: colors.blackAndWhite.shade500);
    final usesCountStyle = theme.styles.body10.copyWith(color: black600);

    final borderRadius = BorderRadius.circular(Constants.borderRadiusL);
    final sound = widget.sound;

    return Padding(
      padding: _padding,
      child: InkWell(
        onTap: widget.onTapSelect,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: borderRadius,
              child: InkWell(
                borderRadius: borderRadius,
                onTap: _playPause,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PicnicImage(
                      source: PicnicImageSource.imageUrl(
                        sound.icon,
                        width: _imageSize.width,
                        height: _imageSize.height,
                      ),
                    ),
                    if (!widget.isPlaying) Image.asset(Assets.images.soundsPlay.path),
                    if (widget.isPlaying) Image.asset(Assets.images.soundsPause.path),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: _elementsPadding,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        sound.title,
                        style: nameStyle,
                      ),
                      const SizedBox(
                        width: _playAnimationPadding,
                      ),
                      if (widget.isPlaying)
                        Lottie.asset(
                          Assets.lottie.soundAttachmentPlaying,
                          width: _playAnimationSize.width,
                          height: _playAnimationSize.height,
                          fit: BoxFit.fill,
                        ),
                    ],
                  ),
                  Text(
                    sound.creator,
                    style: artistStyle,
                  ),
                  Text(
                    sound.duration.formattedMMss,
                    style: durationStyle,
                  ),
                ],
              ),
            ),
            Text(
              sound.usesCount.formattingToStat().toLowerCase(),
              style: usesCountStyle,
            ),
            const SizedBox(
              width: _usesCountPadding,
            ),
            Image.asset(Assets.images.soundsSelect.path),
          ],
        ),
      ),
    );
  }

  void _playPause() {
    widget.onTapPlayPause();
  }
}
