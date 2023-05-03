import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_group.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../../mocks/stubs.dart';

void main() {
  final messages = [
    Stubs.textMessage.copyWith(id: const Id("1"), author: Stubs.user),
    Stubs.textMessage.copyWith(id: const Id("2"), author: Stubs.user),
    Stubs.textMessage.copyWith(id: const Id("3"), author: Stubs.user),
    Stubs.textMessage.copyWith(id: const Id("4"), author: Stubs.user2),
    Stubs.textMessage.copyWith(id: const Id("5"), author: Stubs.user2),
    Stubs.textMessage.copyWith(id: const Id("6"), author: Stubs.user),
    Stubs.textMessage.copyWith(id: const Id("7"), author: Stubs.user2),
    Stubs.textMessage.copyWith(id: const Id("8"), author: Stubs.user),
    Stubs.textMessage.copyWith(id: const Id("9"), author: Stubs.user),
    Stubs.textMessage.copyWith(id: const Id("10"), author: Stubs.user),
  ];

  test(
    "should split messages into groups by author",
    () {
      final groups = ChatMessageGroup.bySplittingMessages(messages);
      expect(groups.length, 5);
      expect(groups[0].author, Stubs.user);
      expect(groups[0].messages.every((it) => it.author == Stubs.user), true);
      expect(groups[0].messages.length, 3);
      expect(groups[1].author, Stubs.user2);
      expect(groups[1].messages.every((it) => it.author == Stubs.user2), true);
      expect(groups[1].messages.length, 2);
      expect(groups[2].author, Stubs.user);
      expect(groups[2].messages.every((it) => it.author == Stubs.user), true);
      expect(groups[2].messages.length, 1);
      expect(groups[3].author, Stubs.user2);
      expect(groups[3].messages.every((it) => it.author == Stubs.user2), true);
      expect(groups[3].messages.length, 1);
      expect(groups[4].author, Stubs.user);
      expect(groups[4].messages.every((it) => it.author == Stubs.user), true);
      expect(groups[4].messages.length, 3);
      expect(
        groups.expand((element) => element.messages).map((e) => e.id.value).toList(),
        ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
      );
    },
  );
}
