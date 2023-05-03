import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/hexagon_container/picnic_hexagon_path_builder.dart';

class PicnicHexagonClipper extends CustomClipper<Path> {
  PicnicHexagonClipper(this.pathBuilder);

  final PicnicHexagonPathBuilder pathBuilder;

  @override
  Path getClip(Size size) => pathBuilder.build(size);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => oldClipper != this;
}
