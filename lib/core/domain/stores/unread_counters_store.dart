import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';
import 'package:picnic_app/utils/extensions/list_extension.dart';

class UnreadCountersStore extends Cubit<List<UnreadChat>> {
  UnreadCountersStore({List<UnreadChat>? unreadChats}) : super(unreadChats ?? List.empty());

  List<UnreadChat> get unreadChats => state;

  set unreadChats(List<UnreadChat> unreadChats) {
    tryEmit(unreadChats);
  }

  void add(UnreadChat unReadChat) {
    if (_contains(unReadChat)) {
      unreadChats = unreadChats.toList().byUpdatingItem(
            update: (it) => it.copyWith(unreadMessagesCount: unReadChat.unreadMessagesCount),
            itemFinder: (it) => it.chatId.value == unReadChat.chatId.value,
          );
    } else {
      final list = unreadChats.toList();
      list.add(unReadChat);
      unreadChats = list;
    }
  }

  void remove(Id chatId) {
    final list = unreadChats.toList();
    list.removeWhere((it) => it.chatId == chatId);
    unreadChats = list;
  }

  bool _contains(UnreadChat unReadChat) =>
      unreadChats.firstWhere(
        (chat) => chat.chatId.value == unReadChat.chatId.value,
        orElse: () => const UnreadChat.empty(),
      ) !=
      const UnreadChat.empty();
}
