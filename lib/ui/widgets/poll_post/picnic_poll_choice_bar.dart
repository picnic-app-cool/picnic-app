import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicPollChoiceBar extends StatefulWidget {
  const PicnicPollChoiceBar({
    Key? key,
    required this.votesPercetage,
    this.color = Colors.white,
    this.width = _defaultWidth,
  })  : assert(votesPercetage >= 0.0 && votesPercetage <= 1.0),
        super(key: key);

  final double width;
  final Color color;

  ///The [votesPercetage] argument must be between 0.0 and 1.0 inclusive.
  final double votesPercetage;

  static const double _defaultWidth = 8;

  @override
  State<PicnicPollChoiceBar> createState() => _PicnicPollChoiceBarState();
}

class _PicnicPollChoiceBarState extends State<PicnicPollChoiceBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const LongDuration(),
    );

    _createAnimation();

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant PicnicPollChoiceBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _createAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final votesLabel = _animation.value.formattedPercentage;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              votesLabel,
              style: theme.styles.subtitle40.copyWith(
                color: theme.colors.blackAndWhite.shade100,
              ),
            ),
            const Gap(10),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: _animation.value,
                child: Container(
                  width: widget.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(widget.width),
                    ),
                    color: widget.color,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _createAnimation() {
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.votesPercetage,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );
  }
}
