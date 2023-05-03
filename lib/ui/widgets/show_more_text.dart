import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ShowMoreText extends StatefulWidget {
  const ShowMoreText({
    Key? key,
    required this.text,
    required this.style,
    required this.maxWidth,
    required this.maxHeight,
    this.onTapShowMore,
  }) : super(key: key);

  final String text;
  final TextStyle style;
  final double maxWidth;
  final double maxHeight;
  final VoidCallback? onTapShowMore;

  static const _showMorePadding = 12.0;

  @override
  State<ShowMoreText> createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  var _showFullText = false;

  @override
  Widget build(BuildContext context) {
    if (_showFullText) {
      return Text(
        widget.text,
        style: widget.style,
      );
    }

    final showMore = appLocalizations.seeMore;
    final theme = PicnicTheme.of(context);
    final showMoreStyle = widget.style.copyWith(
      color: theme.colors.green.shade600,
      fontWeight: FontWeight.w500,
    );

    final painter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: widget.text,
        style: widget.style,
      ),
    );

    painter.layout(maxWidth: widget.maxWidth);

    final lineMetrics = painter.computeLineMetrics();
    final totalLines = lineMetrics.length;
    final preferredLineHeight = painter.preferredLineHeight;

    if (totalLines * preferredLineHeight < widget.maxHeight) {
      return Text(
        widget.text,
        textAlign: TextAlign.left,
        style: widget.style,
      );
    }

    final maxLines = (widget.maxHeight / preferredLineHeight).floor();

    if (maxLines == 0) {
      return const SizedBox();
    }

    final penultPosition = painter.getPositionForOffset(Offset(0, preferredLineHeight * (maxLines - 1)));
    final finalPosition = painter.getPositionForOffset(Offset(0, preferredLineHeight * maxLines));

    final firstText = widget.text.substring(0, penultPosition.offset).trimRight();
    final secondText = widget.text.substring(penultPosition.offset, finalPosition.offset).trimRight();

    final showMorePainter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: showMore,
        style: showMoreStyle,
      ),
    );
    showMorePainter.layout(maxWidth: widget.maxWidth);
    final showMoreWidth = showMorePainter.computeLineMetrics().firstOrNull?.width ?? 0;

    final showGap = lineMetrics[maxLines - 1].width + showMoreWidth + ShowMoreText._showMorePadding < widget.maxWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (firstText.isNotEmpty) ...[
          Text(
            firstText,
            textAlign: TextAlign.left,
            style: widget.style,
          ),
        ],
        Row(
          children: [
            Flexible(
              child: Text(
                secondText.replaceAll("", "\u{200B}"),
                textAlign: TextAlign.left,
                style: widget.style,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showGap) ...[
              const SizedBox(
                width: 4,
              ),
            ],
            InkWell(
              onTap: onShowMorePressed,
              child: Text(
                showMore,
                style: showMoreStyle,
              ),
            ),
            const SizedBox(
              width: ShowMoreText._showMorePadding,
            ),
          ],
        ),
      ],
    );
  }

  void onShowMorePressed() {
    if (widget.onTapShowMore != null) {
      widget.onTapShowMore?.call();
      return;
    }
    setState(() {
      _showFullText = true;
    });
  }
}
