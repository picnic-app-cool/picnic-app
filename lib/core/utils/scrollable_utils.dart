import 'package:flutter/widgets.dart';

double getContextOffsetInScrollable(BuildContext context) {
  final anchorContext = context;
  final anchorRenderBox = anchorContext.findRenderObject() as RenderBox?;
  final scrollable = Scrollable.of(context);
  final scrollableRenderBox = scrollable.context.findRenderObject() as RenderBox?;
  final scrollController = scrollable.widget.controller!;
  final offset = anchorRenderBox?.localToGlobal(Offset.zero, ancestor: scrollableRenderBox);
  return offset!.dy + scrollController.offset;
}
