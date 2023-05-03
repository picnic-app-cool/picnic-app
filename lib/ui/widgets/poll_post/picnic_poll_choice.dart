import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_choice_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicPollChoice extends StatelessWidget {
  const PicnicPollChoice({
    Key? key,
    required this.voted,
    required this.imagePosition,
    this.userImageUrl = const ImageUrl.empty(),
    this.showResult = false,
    this.imageUrl = const ImageUrl.empty(),
    this.votesPercentage = 0,
    this.withRoundedCorners = false,
  })  : assert(votesPercentage >= 0.0 && votesPercentage <= 1.0),
        super(key: key);

  final ImageUrl imageUrl;
  final PicnicPollImagePosition imagePosition;
  final bool voted;
  final bool showResult;
  final ImageUrl userImageUrl;

  ///The [votesPercentage] argument must be between 0.0 and 1.0 inclusive.
  final double votesPercentage;

  final bool withRoundedCorners;

  static const double _borderRadius = 24;
  static const double _defaultOpacity = 0.5;
  static const double _userAvatarSize = 60;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final imageExists = imageUrl != const ImageUrl.empty();
    final defaultPollImage = Container(
      color: imagePosition == PicnicPollImagePosition.left ? theme.colors.cyan : theme.colors.teal,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: withRoundedCorners
                ? BorderRadius.horizontal(
                    left: imagePosition == PicnicPollImagePosition.left
                        ? const Radius.circular(_borderRadius)
                        : Radius.zero,
                    right: imagePosition == PicnicPollImagePosition.right
                        ? const Radius.circular(_borderRadius)
                        : Radius.zero,
                  )
                : BorderRadius.zero,
            child: InkWell(
              child: imageExists
                  ? PicnicImage(
                      source: PicnicImageSource.imageUrl(imageUrl, fit: BoxFit.cover),
                    )
                  : defaultPollImage,
            ),
          ),
        ),
        AnimatedOpacity(
          curve: Curves.easeIn,
          duration: const ShortDuration(),
          opacity: showResult ? _defaultOpacity : 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: withRoundedCorners
                  ? BorderRadius.horizontal(
                      left: imagePosition == PicnicPollImagePosition.left
                          ? const Radius.circular(_borderRadius)
                          : Radius.zero,
                      right: imagePosition == PicnicPollImagePosition.right
                          ? const Radius.circular(_borderRadius)
                          : Radius.zero,
                    )
                  : BorderRadius.zero,
              color: Colors.black,
            ),
          ),
        ),
        Positioned.fill(
          child: Column(
            children: [
              const Gap(32),
              Flexible(
                child: AnimatedOpacity(
                  curve: Curves.easeIn,
                  duration: const ShortDuration(),
                  opacity: voted ? 1 : 0,
                  child: Column(
                    children: [
                      PicnicAvatar(
                        backgroundColor: theme.colors.blue.shade100,
                        size: _userAvatarSize,
                        boxFit: PicnicAvatarChildBoxFit.cover,
                        imageSource: PicnicImageSource.url(
                          userImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Gap(6),
                      Text(
                        appLocalizations.pollVoteLabel,
                        style: theme.styles.body10.copyWith(
                          color: Colors.white.withOpacity(_defaultOpacity),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (showResult)
                Expanded(
                  child: PicnicPollChoiceBar(
                    color: imagePosition == PicnicPollImagePosition.left ? theme.colors.green : theme.colors.red,
                    votesPercetage: votesPercentage,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

enum PicnicPollImagePosition {
  left,
  right,
}
