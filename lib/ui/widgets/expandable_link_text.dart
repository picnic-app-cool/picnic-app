import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linkify/linkify.dart';

typedef ExpandTextBuilder = Text Function(BuildContext context, bool isExpanded);
typedef LinkCallback = void Function(LinkableElement link);

class ExpandableLinkText extends StatefulWidget {
  const ExpandableLinkText(
    this.text, {
    required this.expandTextBuilder,
    this.textStyle,
    this.linkStyle,
    this.textDirection,
    this.onTapLink,
    this.onTap,
    this.maxLines,
    this.maxWidth,
    this.selectable = true,
    this.overflow = TextOverflow.clip,
    this.options = const LinkifyOptions(),
    this.linkifiers = defaultLinkifiers,
    super.key,
  });

  final String text;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;
  final TextDirection? textDirection;
  final ExpandTextBuilder expandTextBuilder;
  final bool selectable;
  final LinkifyOptions options;
  final LinkCallback? onTapLink;
  final VoidCallback? onTap;
  final int? maxLines;
  final double? maxWidth;
  final TextOverflow overflow;
  final List<Linkifier> linkifiers;

  @override
  State<ExpandableLinkText> createState() => _ExpandableLinkTextState();
}

class _ExpandableLinkTextState extends State<ExpandableLinkText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.textStyle ?? DefaultTextStyle.of(context).style;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final maxWidth = widget.maxWidth ?? MediaQuery.of(context).size.width;

    final richText = RichText(
      textDirection: textDirection,
      text: buildTextSpan(widget.text, textStyle),
    );

    final textPainter = TextPainter(
      text: richText.text,
      textAlign: richText.textAlign,
      textDirection: richText.textDirection,
      textScaleFactor: richText.textScaleFactor,
      strutStyle: richText.strutStyle,
    );

    textPainter.layout(maxWidth: maxWidth);
    final lineMetrics = textPainter.computeLineMetrics();
    final totalLines = lineMetrics.length;
    final preferredLineHeight = textPainter.preferredLineHeight;
    final lineHeightStyle = textStyle.height ?? 1;
    final preferredLineHeightWithStyle = (preferredLineHeight * lineHeightStyle).ceil().toDouble();

    final maxLines = widget.maxLines ?? totalLines;
    if (totalLines <= maxLines) {
      //ignore: avoid-returning-widgets
      return buildText(richText.text);
    }

    final splitOffset = textPainter.getPositionForOffset(Offset(0, preferredLineHeightWithStyle * maxLines)).offset;

    final ellipsize = widget.overflow == TextOverflow.ellipsis;

    final ellipsisSpan = TextSpan(text: ellipsize ? '...' : null, style: textStyle);
    final ellipsisSpanLength = ellipsisSpan.text?.length ?? 0;

    final gapSpan = TextSpan(text: ' ', style: textStyle);
    final gapSpanLength = gapSpan.text?.length ?? 0;

    final expandText = widget.expandTextBuilder(context, _isExpanded);
    final expandTextSpan = TextSpan(
      text: expandText.data,
      style: expandText.style,
      recognizer: TapGestureRecognizer()..onTap = () => setState(() => _isExpanded = !_isExpanded),
    );
    final expandTextLength = expandTextSpan.text?.length ?? 0;

    var expandTextOffset = ellipsisSpanLength + gapSpanLength + expandTextLength;

    try {
      final beforeSplitOffset =
          textPainter.getPositionForOffset(Offset(0, preferredLineHeightWithStyle * (maxLines - 1))).offset;
      final lastLineLength = splitOffset - beforeSplitOffset;

      //ignore: no-magic-number
      if (lastLineLength < 10) {
        expandTextOffset = 0;
      }
    } catch (_) {
      expandTextOffset = 0;
    }

    final lineCutOffset = splitOffset - expandTextOffset;

    final firstText = widget.text.substring(0, lineCutOffset);
    final secondText = widget.text.substring(lineCutOffset);

    final combinedSpan = TextSpan(
      children: [
        buildTextSpan(firstText, textStyle),
        if (!_isExpanded) ellipsisSpan,
        if (_isExpanded) buildTextSpan(secondText, textStyle),
        gapSpan,
        expandTextSpan,
      ],
    );
    //ignore: avoid-returning-widgets
    return buildText(combinedSpan);
  }

  Widget buildText(InlineSpan inlineSpan) {
    return widget.selectable
        ? SelectableText.rich(
            TextSpan(children: [inlineSpan]),
            textDirection: widget.textDirection,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            onTap: widget.onTap,
          )
        : Text.rich(inlineSpan, textDirection: widget.textDirection);
  }

//ignore: long-method
  TextSpan buildTextSpan(String text, TextStyle textStyle) {
    final elements = linkify(
      text,
      options: widget.options,
      linkifiers: widget.linkifiers,
    );

    final linkStyle = textStyle
        .copyWith(
          color: Colors.blueAccent,
          decoration: TextDecoration.underline,
        )
        .merge(widget.linkStyle);

    return TextSpan(
      children: elements.map<InlineSpan>(
        (element) {
          return element is LinkableElement
              ? TextSpan(
                  text: element.text,
                  style: linkStyle,
                  recognizer: widget.onTapLink != null
                      ? (TapGestureRecognizer()..onTap = () => widget.onTapLink?.call(element))
                      : null,
                )
              : TextSpan(text: element.text, style: textStyle);
        },
      ).toList(),
    );
  }
}
