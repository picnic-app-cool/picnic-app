import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class UnorderedTextListItem extends StatelessWidget {
  const UnorderedTextListItem({
    Key? key,
    required this.textSrc,
  }) : super(key: key);

  final String textSrc;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final textStyleBody20 = theme.styles.body20;

    return ListTile(
      title: Column(
        children: LineSplitter.split(textSrc).map((line) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("• "),
              Expanded(
                child: Text(
                  line,
                  style: textStyleBody20,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
