import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/picnic_stat.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PicnicStats extends StatelessWidget {
  const PicnicStats({
    Key? key,
    required this.stats,
    required this.onTap,
    this.isLoading = false,
    this.usage = PicnicStatUsage.circle,
  }) : super(key: key);

  final List<PicnicStat> stats;
  final Function(StatType) onTap;
  final bool isLoading;
  final PicnicStatUsage usage;

  @override
  Widget build(BuildContext context) {
    final themeData = PicnicTheme.of(context);
    final styles = themeData.styles;
    final colors = themeData.colors;

    final _textStyle = styles.title30;
    final _labelStyle = styles.caption10.copyWith(color: colors.blackAndWhite.shade800);

    return Row(
      mainAxisAlignment:
          usage == PicnicStatUsage.profile ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.spaceBetween,
      crossAxisAlignment: usage == PicnicStatUsage.profile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: stats
          .map(
            (stat) => isLoading
                ? const PicnicLoadingIndicator()
                : _PicnicStatColumnWidget(
                    value: stat.count,
                    valueStyle: _textStyle,
                    subtext: stat.type.title,
                    subtextStyle: _labelStyle,
                    onTap: () => onTap(stat.type),
                    usage: usage,
                  ),
          )
          .toList(),
    );
  }
}

class _PicnicStatColumnWidget extends StatelessWidget {
  const _PicnicStatColumnWidget({
    Key? key,
    required this.value,
    required this.valueStyle,
    required this.subtext,
    required this.subtextStyle,
    this.usage = PicnicStatUsage.circle,
    this.onTap,
  }) : super(key: key);

  final int value;
  final TextStyle valueStyle;
  final String subtext;
  final TextStyle subtextStyle;
  final VoidCallback? onTap;
  final PicnicStatUsage usage;

  @override
  Widget build(BuildContext context) {
    final formattingToStat = value.formattingToStat();
    final labelOnStatsColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PicnicStatsEmojiRowWidget(
          label: subtext,
          labelStyle: subtextStyle,
        ),
        Text(
          formattingToStat,
          style: valueStyle,
        ),
      ],
    );

    final statsOnLabelColumn = Column(
      children: [
        _PicnicStatsEmojiRowWidget(
          label: subtext,
          labelStyle: subtextStyle,
        ),
        const Padding(padding: EdgeInsets.all(4.0)),
        Text(
          formattingToStat,
          style: valueStyle,
        ),
      ],
    );
    return InkWell(
      onTap: onTap,
      child: usage == PicnicStatUsage.profile ? statsOnLabelColumn : labelOnStatsColumn,
    );
  }
}

class _PicnicStatsEmojiRowWidget extends StatelessWidget {
  const _PicnicStatsEmojiRowWidget({
    Key? key,
    required this.label,
    required this.labelStyle,
  }) : super(key: key);

  final String label;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: labelStyle,
        ),
      ],
    );
  }
}

enum PicnicStatUsage {
  profile,
  circle,
}
