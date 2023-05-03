import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/widgets/chat_mentions/chat_suggested_users_list.dart';

class ChatSuggestionsComposer extends StatefulWidget {
  const ChatSuggestionsComposer({
    required this.textEditingController,
    required this.child,
    this.suggestedUsersToMention = const PaginatedList.empty(),
    this.onTapSuggestedMention,
    super.key,
  });

  final TextEditingController textEditingController;
  final Widget child;
  final PaginatedList<UserMention> suggestedUsersToMention;
  final ValueChanged<UserMention>? onTapSuggestedMention;

  @override
  State<ChatSuggestionsComposer> createState() => _ChatSuggestionsComposerState();
}

class _ChatSuggestionsComposerState extends State<ChatSuggestionsComposer> {
  late LayerLink _suggestedUsersLayerLink;
  OverlayEntry? _suggestedUsersOverlayEntry;

  @override
  void initState() {
    super.initState();
    _suggestedUsersLayerLink = LayerLink();

    widget.textEditingController.addListener(() {
      // The delay is necessary because of waiting for suggestedUsersToMention
      // to be updated from the model
      Future.delayed(const LongDuration(), _updateSuggestedUsers);
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
      child: widget.child,
    );
  }

  void _updateSuggestedUsers() {
    _removeSuggestedUsersOverlayEntry();
    if (widget.suggestedUsersToMention.items.isNotEmpty) {
      _createSuggestedUsersOverlayEntry(context);
    }
  }

  // ignore: long-method
  void _createSuggestedUsersOverlayEntry(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final listMaxHeight = size.height * 0.4;
    final listWidth = size.width - 42;
    final listDyOffset = listMaxHeight + 5;

    _suggestedUsersOverlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _removeSuggestedUsersOverlayEntry,
            ),
            Positioned(
              width: listWidth,
              height: listMaxHeight,
              child: CompositedTransformFollower(
                link: _suggestedUsersLayerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, -listDyOffset),
                child: ChatSuggestedUsersList(
                  suggestedUsersToMention: widget.suggestedUsersToMention,
                  onTapSuggestedMention: _onTapSuggestedMention,
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_suggestedUsersOverlayEntry!);
  }

  void _removeSuggestedUsersOverlayEntry() {
    _suggestedUsersOverlayEntry?.remove();
    _suggestedUsersOverlayEntry = null;
  }

  void _onTapSuggestedMention(UserMention user) {
    widget.onTapSuggestedMention?.call(user);
    _removeSuggestedUsersOverlayEntry();
  }
}
