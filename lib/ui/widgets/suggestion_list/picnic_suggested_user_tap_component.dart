import 'dart:async';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/ui/widgets/suggestion_list/picnic_suggested_users_list.dart';

class PicnicSuggestedUserTapComponent extends StatefulWidget {
  const PicnicSuggestedUserTapComponent({
    super.key,
    required this.compositedChild,
    this.suggestedUsersToMention,
    required this.onChanged,
    required this.onTapSuggestedMention,
    required this.offSet,
  });

  final Widget compositedChild;
  final PaginatedList<UserMention>? suggestedUsersToMention;
  final ValueChanged<String>? onChanged;
  final ValueChanged<UserMention>? onTapSuggestedMention;
  final Offset? offSet;

  @override
  State<PicnicSuggestedUserTapComponent> createState() => _PicnicSuggestedUserComponentState();
}

class _PicnicSuggestedUserComponentState extends State<PicnicSuggestedUserTapComponent> {
  late Offset _offSet;
  late LayerLink _suggestedUsersLayerLink;
  late TextEditingController? _textEditingController;
  OverlayEntry? _suggestedUsersOverlayEntry;

  @override
  void initState() {
    super.initState();
    _offSet = widget.offSet ?? Offset.zero;
    _suggestedUsersLayerLink = LayerLink();
    _textEditingController = TextEditingController();
    _textEditingController?.addListener(() {
      Future.delayed(const LongDuration(), _updateSuggestedUsers);
    });
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    _removeSuggestedUsersOverlayEntry();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _createSuggestedUsers,
      child: CompositedTransformTarget(
        link: _suggestedUsersLayerLink,
        child: widget.compositedChild,
      ),
    );
  }

  // ignore: long-method
  void _createSuggestedUsersOverlayEntry(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final listMaxHeight = size.height * 0.4;
    final listWidth = size.width - 64;

    _suggestedUsersOverlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // It's necessary to remove the overlay whenever TAP outside the
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _removeSuggestedUsersOverlayEntry,
            ),
            Positioned(
              height: listMaxHeight,
              width: listWidth,
              child: CompositedTransformFollower(
                targetAnchor: Alignment.bottomLeft,
                offset: _offSet,
                link: _suggestedUsersLayerLink,
                showWhenUnlinked: false,
                child: PicnicSuggestedUsersList(
                  onChanged: widget.onChanged,
                  textController: _textEditingController,
                  suggestedUsersToMention: widget.suggestedUsersToMention ?? const PaginatedList.empty(),
                  onTapSuggestedMention: _updateSuggestedText,
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_suggestedUsersOverlayEntry!);
  }

  void _createSuggestedUsers() {
    _removeSuggestedUsersOverlayEntry();
    _createSuggestedUsersOverlayEntry(context);
  }

  void _updateSuggestedUsers() {
    _suggestedUsersOverlayEntry?.markNeedsBuild();
    if (widget.suggestedUsersToMention != null) {
      if (widget.suggestedUsersToMention!.items.isNotEmpty) {
        _suggestedUsersOverlayEntry?.markNeedsBuild();
      }
    }
  }

  void _removeSuggestedUsersOverlayEntry() {
    if (_suggestedUsersOverlayEntry != null) {
      _suggestedUsersOverlayEntry?.remove();
      _suggestedUsersOverlayEntry = null;
    }
  }

  void _updateSuggestedText(UserMention value) {
    if (widget.onTapSuggestedMention != null) {
      widget.onTapSuggestedMention!(value);
      _textEditingController!.text = '';
      _removeSuggestedUsersOverlayEntry();
    }
  }
}
