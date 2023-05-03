import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';

class LinkPlaceholder extends StatelessWidget {
  const LinkPlaceholder({
    Key? key,
    required this.linkUrl,
  }) : super(key: key);

  final LinkUrl linkUrl;

  static const _defaultLinkColors = [
    Color(0xffffb4b4),
    Color(0xff80d079),
    Color(0xff80dcf0),
    Color(0xff6190eb),
    Color(0xffae71fc),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _defaultLinkColors[linkUrl.url.hashCode % _defaultLinkColors.length],
    );
  }
}
