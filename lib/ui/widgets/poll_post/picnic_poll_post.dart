import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/double_tap_detector.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_choice.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

// TODO: Accept left and right [PollAnswer] type as arguments and return the same type on `onVote` function
class PicnicPollPost extends StatelessWidget {
  const PicnicPollPost({
    Key? key,
    required this.onVote,
    this.onDoubleTap,
    this.userImageUrl = const ImageUrl.empty(),
    this.vote,
    this.leftImage = const ImageUrl.empty(),
    this.leftVotes = 0,
    this.rightImage = const ImageUrl.empty(),
    this.rightVotes = 0,
    this.isLoading = false,
    this.withRoundedCorners = false,
  }) : super(key: key);

  final bool isLoading;

  ///The image on the left side of the post.
  final ImageUrl leftImage;

  ///The [leftVotes] argument must be between 0.0 and 1.0 inclusive.
  final double leftVotes;

  ///The image on the right side of the post.
  final ImageUrl rightImage;

  ///The [rightVotes] argument must be between 0.0 and 1.0 inclusive.
  final double rightVotes;

  ///The initial state of the poll post. If null, the user will be
  ///able to vote.
  ///
  ///If not null, the voting results will be displayed.
  final PicnicPollVote? vote;

  ///The user's image url to show in the vote.
  final ImageUrl userImageUrl;

  ///The callback to call when the user votes.
  ///Returns the user's vote.
  final ValueChanged<PicnicPollVote> onVote;

  /// Double tap callback to like the entire post
  final VoidCallback? onDoubleTap;

  /// If true, the corners of the poll will be rounded.
  final bool withRoundedCorners;

  static const double _tapTextOpacity = 0.8;
  static const double _tapTextBottomPosition = 30;
  static const int _animationMsDuration = 250;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final voteExists = vote != null;

    return DoubleTapDetector(
      onDoubleTap: () => onDoubleTap?.call(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: voteExists ? null : () => onVote(PicnicPollVote.left),
                  child: PicnicPollChoice(
                    key: const ValueKey(PicnicPollVote.left),
                    userImageUrl: userImageUrl,
                    votesPercentage: leftVotes,
                    showResult: voteExists || isLoading,
                    voted: voteExists && vote == PicnicPollVote.left,
                    imageUrl: leftImage,
                    imagePosition: PicnicPollImagePosition.left,
                    withRoundedCorners: withRoundedCorners,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: voteExists ? null : () => onVote(PicnicPollVote.right),
                  child: PicnicPollChoice(
                    key: const ValueKey(PicnicPollVote.right),
                    userImageUrl: userImageUrl,
                    votesPercentage: rightVotes,
                    showResult: voteExists || isLoading,
                    voted: voteExists && vote == PicnicPollVote.right,
                    imageUrl: rightImage,
                    imagePosition: PicnicPollImagePosition.right,
                    withRoundedCorners: withRoundedCorners,
                  ),
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: _animationMsDuration),
            bottom: voteExists ? -_tapTextBottomPosition : _tapTextBottomPosition,
            child: Text(
              appLocalizations.tapLeftOrRightHint,
              textAlign: TextAlign.center,
              style: theme.styles.body30.copyWith(
                color: Colors.white.withOpacity(_tapTextOpacity),
              ),
            ),
          ),
          if (isLoading)
            PicnicLoadingIndicator(
              color: theme.colors.blackAndWhite.shade100,
            ),
        ],
      ),
    );
  }
}

enum PicnicPollVote {
  left,
  right,
}
