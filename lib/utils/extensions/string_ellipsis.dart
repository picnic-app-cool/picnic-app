import 'package:flutter/material.dart';

extension StringEllipsis on String {
  /// Replaces all spaces in text with Unicode No-Break Space character.
  ///
  /// ```dart
  /// Text(
  ///   'this is a longwordtobreak'.tight(), // "this is a longword..."
  ///   style: tagTitleStyle,
  ///   overflow: TextOverflow.ellipsis,
  /// )
  /// ```
  ///
  /// https://github.com/flutter/flutter/issues/18761
  String tight() {
    return Characters(this).replaceAll(Characters(' '), Characters('\u{000A0}')).toString();
  }
}
