import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicMarkdownText extends StatelessWidget {
  const PicnicMarkdownText({
    required this.markdownSource,
    this.allowScroll = false,
    this.selectableText = false,
    this.padding = EdgeInsets.zero,
    this.scrollPhysics,
    this.onTapLink,
    this.onTapText,
    this.textStyle,
    this.linkStyle,
  });

  final String markdownSource;
  final bool allowScroll;
  final bool selectableText;
  final EdgeInsets padding;
  final ScrollPhysics? scrollPhysics;

  final TextStyle? textStyle;
  final TextStyle? linkStyle;

  final void Function(
    String text,
    String? href,
    String title,
  )? onTapLink;
  final VoidCallback? onTapText;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    final _defaultTextStyle = styles.body20;
    final _defaultLinkStyle = _defaultTextStyle.copyWith(
      color: colors.lightBlue,
    );

    final _markdownStyle = MarkdownStyleSheet(
      p: textStyle ?? _defaultTextStyle,
      a: linkStyle ?? _defaultLinkStyle,
    );

    if (allowScroll) {
      return Markdown(
        data: markdownSource,
        selectable: selectableText,
        onTapLink: onTapLink,
        onTapText: onTapText,
        styleSheet: _markdownStyle,
        shrinkWrap: true,
        padding: padding,
        physics: scrollPhysics,
      );
    }

    return Padding(
      padding: padding,
      child: MarkdownBody(
        data: markdownSource,
        selectable: selectableText,
        onTapLink: onTapLink,
        onTapText: onTapText,
        styleSheet: _markdownStyle,
      ),
    );
  }
}
