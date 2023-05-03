import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';

//ignore_for_file: no-magic-number, prefer-extracting-callbacks
class AttachmentsGrid extends StatelessWidget {
  const AttachmentsGrid({
    required this.attachments,
    required this.itemBuilder,
    super.key,
  });

  final List<Attachment> attachments;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    final attachmentCount = attachments.take(6).length;
    return StaggeredGrid.count(
      axisDirection: AxisDirection.down,
      crossAxisCount: 6,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(attachmentCount, (index) {
        return StaggeredGridTile.count(
          crossAxisCellCount: _getCrossAxisCellCount(attachmentCount, index),
          mainAxisCellCount: _getMainAxisCellCount(attachmentCount, index),
          child: itemBuilder(context, index),
        );
      }),
    );
  }

  int _getCrossAxisCellCount(int attachmentCount, int index) {
    switch (attachmentCount) {
      case 1:
        return 6;
      case 2:
      case 3:
      case 4:
        return 3;
      case 5:
        return index == 0 || index == 1 ? 3 : 2;
    }

    return 2;
  }

  int _getMainAxisCellCount(int attachmentCount, int index) {
    switch (attachmentCount) {
      case 1:
      case 2:
        return 6;
      case 3:
        return index == 0 ? 6 : 3;
    }
    return 2;
  }
}
