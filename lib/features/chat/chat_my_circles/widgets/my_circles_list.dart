import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/widgets/chat_list_item/chat_list_item.dart';
import 'package:picnic_app/features/chat/widgets/chat_list_item/chat_list_item_displayable.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class MyCirclesList extends StatelessWidget {
  const MyCirclesList({
    Key? key,
    required this.circleChats,
    required this.now,
    required this.loadMore,
    required this.onTapCircle,
  }) : super(key: key);

  final PaginatedList<ChatListItemDisplayable> circleChats;
  final DateTime now;
  final Future<void> Function() loadMore;
  final Function(BasicChat) onTapCircle;

  @override
  Widget build(BuildContext context) => PicnicPagingListView<ChatListItemDisplayable>(
        padding: const EdgeInsets.only(top: Constants.defaultPadding),
        paginatedList: circleChats,
        loadMore: loadMore,
        itemBuilder: (context, item) => ChatListItem(
          onTapChat: (_) => onTapCircle(item.chat),
          model: item,
          now: now,
          circle: item.circle,
        ),
        separatorBuilder: (context, index) => const Gap(16),
        loadingBuilder: (_) => const PicnicLoadingIndicator(),
      );
}
