import 'package:flutter/material.dart';

class TextBoundariesResolver {
  const TextBoundariesResolver(
    this.text,
    this.constraints,
  );

  final TextSpan text;
  final BoxConstraints constraints;

  /// calculates given [text] height in [constraints]
  double calculateTextHeight({required BuildContext context}) {
    return (_getTextPainter(context)..layout(maxWidth: constraints.maxWidth)).size.height;
  }

  /// calculates preffered line height for given [text] in [constraints]
  double calculatePrefferedLineHeight({required BuildContext context}) {
    return _getTextPainter(context).preferredLineHeight;
  }

  TextPainter _getTextPainter(BuildContext context) => TextPainter(
        text: text,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        textDirection: TextDirection.ltr,
      );
}
