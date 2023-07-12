import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/chat_dms/widgets/swipe_item_dismissible.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_list_item_displayable.dart';
import 'package:picnic_app/features/chat/widgets/chat_list_item/chat_list_item.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class DmsList extends StatelessWidget {
  const DmsList({
    Key? key,
    required this.dmChats,
    required this.now,
    required this.loadMoreChats,
    required this.onTapConfirmLeaveChat,
    this.onTapChat,
  }) : super(key: key);

  final PaginatedList<ChatListItemDisplayable> dmChats;
  final DateTime now;
  final Function(BasicChat)? onTapChat;
  final Future<void> Function() loadMoreChats;
  final Function(BasicChat) onTapConfirmLeaveChat;

  @override
  Widget build(BuildContext context) => PicnicPagingListView<ChatListItemDisplayable>(
        padding: const EdgeInsets.only(top: Constants.defaultPadding),
        paginatedList: dmChats,
        loadMore: loadMoreChats,
        loadingBuilder: (_) => const PicnicLoadingIndicator(),
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, item) => SwipeItemDismissible(
          onTapConfirmLeaveChat: onTapConfirmLeaveChat,
          key: Key(dmChats.items.indexOf(item).toString()),
          chatListItem: ChatListItem(
            onTapChat: onTapChat,
            model: item,
            now: now,
          ),
        ),
      );
}
