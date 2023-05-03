import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/seeds/widgets/block_widget.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_countdown.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ElectionCountdownWidget extends StatelessWidget {
  const ElectionCountdownWidget({
    Key? key,
    required this.deadline,
    required this.currentTimeProvider,
    required this.percentage,
    this.showCountDownWidget = false,
  }) : super(key: key);

  final int percentage;
  final DateTime? deadline;
  final CurrentTimeProvider currentTimeProvider;
  final bool showCountDownWidget;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final purpleShade500 = colors.purple.shade500;
    final percentFormat = appLocalizations.percentFormat(percentage);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.largePadding),
      child: BlockWidget(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    appLocalizations.electionVoteTimeTitle(percentFormat),
                    style: styles.body20.copyWith(color: purpleShade500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Image.asset(
                  Assets.images.tusers.path,
                  color: purpleShade500,
                ),
              ],
            ),
            if (showCountDownWidget) ...[
              const Divider(),
              PicnicCountdown(
                deadline: deadline!,
                currentTimeProvider: currentTimeProvider,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
