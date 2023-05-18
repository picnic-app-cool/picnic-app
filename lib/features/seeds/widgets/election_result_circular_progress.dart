import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/diagrams/picnic_half_circle_dots_progress_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

//ignore_for_file: unused-code, unused-files
class ElectionResultCircularProgress extends StatelessWidget {
  const ElectionResultCircularProgress({
    Key? key,
    required this.progress,
    required this.seedsVoted,
  }) : super(key: key);

  final double progress;
  final int seedsVoted;

  static const _textHeight = 0.5;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    final bwShade900 = colors.blackAndWhite.shade900;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PicnicHalfCircleDotsProgressBar(progress: progress),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  seedsVoted.toString(),
                  style: styles.display20.copyWith(
                    color: bwShade900,
                    height: _textHeight,
                  ),
                ),
                Text(
                  appLocalizations.circleElectionSeedsVoted,
                  style: styles.body0.copyWith(color: colors.blackAndWhite.shade600, height: _textHeight),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
