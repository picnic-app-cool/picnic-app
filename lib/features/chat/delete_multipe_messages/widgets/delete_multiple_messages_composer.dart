import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/model/delete_multiple_messages_condition.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/widgets/delete_multiple_messages_conditions_list.dart';

class DeleteMultipleMessagesComposer extends StatefulWidget {
  const DeleteMultipleMessagesComposer({
    required this.conditions,
    required this.onTapItem,
    required this.child,
    super.key,
  });

  final List<DeleteMultipleMessagesCondition> conditions;
  final ValueChanged<DeleteMultipleMessagesCondition> onTapItem;
  final Widget child;

  @override
  State<DeleteMultipleMessagesComposer> createState() => _DeleteMultipleMessagesComposerState();
}

class _DeleteMultipleMessagesComposerState extends State<DeleteMultipleMessagesComposer> {
  late LayerLink _conditionsLayerLink;
  OverlayEntry? _conditionsOverlayEntry;

  @override
  void initState() {
    super.initState();
    _conditionsLayerLink = LayerLink();
  }

  @override
  void dispose() {
    _removeConditionsOverlayEntry();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DeleteMultipleMessagesComposer oldWidget) {
    super.didUpdateWidget(oldWidget);

    Future.delayed(const ExtraShortDuration(), _updateConditions);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _conditionsLayerLink,
      child: widget.child,
    );
  }

  void _updateConditions() {
    _removeConditionsOverlayEntry();
    if (widget.conditions.isNotEmpty) {
      _createConditionsOverlayEntry(context);
    }
  }

  // ignore: long-method
  void _createConditionsOverlayEntry(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const listMaxHeight = 310.0;
    final listWidth = size.width - 42.0;
    const listDyOffset = listMaxHeight + 5.0;

    _conditionsOverlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _removeConditionsOverlayEntry,
            ),
            Positioned(
              width: listWidth,
              height: listMaxHeight,
              child: CompositedTransformFollower(
                link: _conditionsLayerLink,
                showWhenUnlinked: false,
                offset: const Offset(0.0, -listDyOffset),
                child: DeleteMultipleMessagesConditionsList(
                  conditions: widget.conditions,
                  onTapItem: _onTapItem,
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_conditionsOverlayEntry!);
  }

  void _onTapItem(DeleteMultipleMessagesCondition item) {
    widget.onTapItem(item);
    _removeConditionsOverlayEntry();
  }

  void _removeConditionsOverlayEntry() {
    _conditionsOverlayEntry?.remove();
    _conditionsOverlayEntry = null;
  }
}
