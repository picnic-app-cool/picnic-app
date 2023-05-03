import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_messages_list/chat_messages_day_widget.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_grouped_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({
    super.key,
    required this.messages,
    required this.loadMore,
    required this.now,
    required this.itemBuilder,
    this.padding,
    this.clipBehavior = Clip.none,
  });

  final PaginatedList<DisplayableChatMessage> messages;
  final Future<void> Function() loadMore;
  final DateTime now;
  final PicnicPagingGroupedItemWidgetBuilder<DisplayableChatMessage> itemBuilder;
  final EdgeInsetsGeometry? padding;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: PicnicPagingGroupedListView<DisplayableChatMessage, String>(
            reverse: true,
            shrinkWrap: true,
            padding: padding,
            clipBehavior: clipBehavior,
            paginatedList: messages,
            groupBy: (message) => message.chatMessage.formatSendAtDay(now),
            groupSeparatorBuilder: (header) => ChatMessagesDayWidget(dayText: header),
            loadMore: loadMore,
            loadingBuilder: (_) => const PicnicLoadingIndicator(),
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    );
  }
}
