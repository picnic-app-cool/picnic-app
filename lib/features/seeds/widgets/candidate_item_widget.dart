import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CandidateItemWidget extends StatelessWidget {
  const CandidateItemWidget({
    Key? key,
    required this.candidate,
    required this.isSelected,
    required this.onTapCandidate,
    required this.isTopCandidatesView,
  }) : super(key: key);

  final VoteCandidate candidate;
  final bool isSelected;
  final VoidCallback onTapCandidate;
  final bool isTopCandidatesView;

  static const double _avatarSize = 42;
  static const _directorPosition = 1;
  static const _runnerUpPosition = 2;
  static const _thirdPosition = 3;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;
    final blackAndWhite = colors.blackAndWhite;
    final borderColor = isSelected ? colors.blue.shade300.withOpacity(0.9) : colors.blackAndWhite.shade300;
    final borderWidth = isSelected ? 3.0 : 1.0;
    const blurRadius = 8.0;
    const opacity = 0.05;
    const borderRadius = 16.0;
    final caption10GreyStyle = styles.caption10.copyWith(color: blackAndWhite.shade600);
    const nrOfDecimalsToShow = 2;

    return GestureDetector(
      onTap: onTapCandidate,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              if (isTopCandidatesView)
                BoxShadow(
                  blurRadius: blurRadius,
                  color: blackAndWhite.shade900.withOpacity(opacity),
                  offset: const Offset(0, 2),
                ),
            ],
            color: blackAndWhite.shade100,
            borderRadius: BorderRadius.circular(borderRadius),
            border: isTopCandidatesView ? null : Border.all(width: borderWidth, color: borderColor),
          ),
          child: Column(
            children: [
              const Gap(12.0),
              Row(
                children: [
                  const Gap(16.0),
                  PicnicAvatar(
                    backgroundColor: blackAndWhite.shade300,
                    size: _avatarSize,
                    boxFit: PicnicAvatarChildBoxFit.cover,
                    imageSource: PicnicImageSource.url(
                      candidate.profilePictureUrl,
                      fit: BoxFit.cover,
                    ),
                    isVerified: candidate.isDirector,
                    verificationBadgeImage: ImageUrl(Assets.images.greenCheckmark.path),
                  ),
                  const Gap(8.0),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            candidate.username,
                            style: styles.title10.copyWith(color: blackAndWhite.shade900),
                          ),
                        ),
                        Text(
                          appLocalizations.ofAllVotes(candidate.votesPercent.toStringAsFixed(nrOfDecimalsToShow)),
                          style: caption10GreyStyle,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        appLocalizations.votesCount(candidate.votesCount.toString()),
                        style: styles.title10.copyWith(
                          color: _getVotesColor(votingPosition: candidate.position, colors: colors),
                        ),
                      ),
                    ],
                  ),
                  const Gap(16.0),
                ],
              ),
              if (candidate.isDirector && isTopCandidatesView)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const Gap(8),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: blackAndWhite.shade300,
                      ),
                      const Gap(8),
                      Row(
                        children: [
                          if (candidate.isDirector && candidate.margin > 0)
                            Text(
                              appLocalizations.directorMargin(candidate.margin.toString()),
                              style: caption10GreyStyle,
                            ),
                          const Spacer(),
                          PicnicTag(
                            title: appLocalizations.electedDirector,
                            titleTextStyle: styles.body0.copyWith(color: blackAndWhite.shade100),
                            backgroundColor: colors.green.shade500,
                            opacity: 1.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              const Gap(12.0),
            ],
          ),
        ),
      ),
    );
  }

  Color _getVotesColor({
    required int votingPosition,
    required PicnicColors colors,
  }) {
    switch (votingPosition) {
      case _directorPosition:
        return colors.yellow.shade500;
      case _runnerUpPosition:
        return colors.blue.shade500;
      case _thirdPosition:
        return colors.purple.shade500;
      default:
        return colors.blackAndWhite.shade700;
    }
  }
}
