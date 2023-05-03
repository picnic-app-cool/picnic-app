import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/ui/widgets/suggestion_list/picnic_suggested_users_list.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';

class PicnicSuggestedUserTypingComponent extends StatefulWidget {
  const PicnicSuggestedUserTypingComponent({
    super.key,
    required this.compositedChild,
    this.textEditingController,
    this.suggestedUsersToMention,
    this.onTapSuggestedMention,
    this.focusNode,
    this.profileStats,
  });

  final Widget compositedChild;
  final TextEditingController? textEditingController;
  final PaginatedList<UserMention>? suggestedUsersToMention;
  final ValueChanged<UserMention>? onTapSuggestedMention;
  final FocusNode? focusNode;
  final ProfileStats? profileStats;

  @override
  State<PicnicSuggestedUserTypingComponent> createState() => _PicnicSuggestedUserComponentState();
}

class _PicnicSuggestedUserComponentState extends State<PicnicSuggestedUserTypingComponent> {
  late LayerLink _suggestedUsersLayerLink;
  OverlayEntry? _suggestedUsersOverlayEntry;

  @override
  void initState() {
    super.initState();
    _suggestedUsersLayerLink = LayerLink();
    widget.textEditingController?.addListener(() {
      if (widget.textEditingController?.text.isNotEmpty == true) {
        Future.delayed(const LongDuration(), _createSuggestedUsers);
      } else {
        _removeSuggestedUsersOverlayEntry();
      }
    });
  }

  @override
  void dispose() {
    _removeSuggestedUsersOverlayEntry();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _suggestedUsersLayerLink,
      child: widget.compositedChild,
    );
  }

  void _createSuggestedUsersOverlayEntry(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final listMaxHeight = size.height * 0.4;
    final listWidth = size.width - 42;

    _suggestedUsersOverlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: listWidth,
          height: listMaxHeight,
          child: CompositedTransformFollower(
            targetAnchor: Alignment.bottomLeft,
            link: _suggestedUsersLayerLink,
            showWhenUnlinked: false,
            child: PicnicSuggestedUsersList(
              suggestedUsersToMention: widget.suggestedUsersToMention ?? const PaginatedList.empty(),
              onTapSuggestedMention: _updateSuggestedText,
              profileStats: widget.profileStats,
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_suggestedUsersOverlayEntry!);
  }

  void _createSuggestedUsers() {
    _removeSuggestedUsersOverlayEntry();
    if (widget.suggestedUsersToMention != null) {
      if (widget.suggestedUsersToMention!.items.isNotEmpty) {
        _createSuggestedUsersOverlayEntry(context);
      }
    }
  }

  void _removeSuggestedUsersOverlayEntry() {
    if (_suggestedUsersOverlayEntry != null) {
      widget.focusNode?.unfocus();
      _suggestedUsersOverlayEntry?.remove();
      _suggestedUsersOverlayEntry = null;
    }
  }

  void _updateSuggestedText(UserMention value) {
    if (widget.onTapSuggestedMention != null) {
      widget.onTapSuggestedMention!(value);
      widget.textEditingController!.text = value.name.formattedUsername;
      Future.delayed(
        const LongDuration(),
        _removeSuggestedUsersOverlayEntry,
      );
    }
  }
}
