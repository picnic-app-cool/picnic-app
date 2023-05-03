import 'package:flutter/material.dart';

enum TextColor {
  none(
    Type.circle,
    Color.fromARGB(
      0,
      0,
      0,
      0,
    ),
  ),
  stone(Type.circle, Color(0XFF4993B3)),
  teal(Type.circle, Color(0XFF2AA3A3)),
  persianGreen(Type.circle, Color(0XFF2AA38D)),
  mantis(Type.circle, Color(0XFF78B363)),
  indigo(Type.circle, Color(0XFF5034FF)),
  purple(Type.circle, Color(0XFF5A24B3)),
  cobalt(Type.circle, Color(0XFF1453B3)),
  navy(Type.circle, Color(0XFF2B3F6C)),
  ruby(Type.circle, Color(0XFFB3243E)),
  blush(Type.circle, Color(0XFFCC4A62)),
  brown(Type.circle, Color(0XFFB34724)),
  granola(Type.circle, Color(0XFFB3921F)),
  watermelon(Type.circle, Color(0XFFFF5D7B)),
  strawberry(Type.circle, Color(0XFFFF3459)),
  tiger(Type.circle, Color(0XFFFF6534)),
  banana(Type.circle, Color(0XFFE8C23E)),
  black(Type.circle, Colors.black);

  const TextColor(this.type, this.color);

  static List<TextColor> get selectableCircleValues => [
        ...TextColor.values.where((element) => element.type == Type.circle),
      ]
        ..remove(TextColor.none)
        ..remove(TextColor.black);

  static TextColor fromString(String value) => TextColor.values.firstWhere(
        (it) => it.name.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => TextColor.strawberry,
      );

  final Type type;
  final Color color;
}

enum Type {
  post,
  circle;
}
