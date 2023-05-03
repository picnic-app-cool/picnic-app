import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class AdditionalHeaderRow extends StatelessWidget {
  const AdditionalHeaderRow({
    super.key,
    required this.header,
    required this.onTapDelete,
  });

  final MapEntry<String, String> header;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: PicnicTheme.of(context).colors.blackAndWhite.shade500)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(child: Center(child: Text(header.key))),
            Expanded(child: Center(child: Text(header.value))),
            IconButton(onPressed: onTapDelete, icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
