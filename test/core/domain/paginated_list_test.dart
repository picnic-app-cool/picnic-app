import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/cursor_direction.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../mocks/stubs.dart';

void main() {
  const emptyList = PaginatedList(
    pageInfo: PageInfo.singlePage(),
    items: [],
  );

  final itemsList1 = PaginatedList(
    pageInfo: const PageInfo.empty().copyWith(
      nextPageId: const Id("1"),
      hasNextPage: true,
    ),
    items: const ["a", "b", "c"],
  );

  final itemsList2 = PaginatedList(
    pageInfo: const PageInfo.empty().copyWith(
      previousPageId: const Id("0"),
      hasPreviousPage: true,
      hasNextPage: false,
    ),
    items: const ["d", "e", "f"],
  );

  test(
    "appending list to empty list works",
    () {
      final append = emptyList + itemsList1;
      expect(append.items, ["a", "b", "c"]);
      expect(append.pageInfo.nextPageId, const Id("1"));
      expect(append.pageInfo.hasNextPage, true);
    },
  );

  test(
    "appending list to another list works",
    () {
      final append = itemsList1 + itemsList2;
      expect(append.items, ["a", "b", "c", "d", "e", "f"]);
      expect(append.pageInfo.nextPageId, const Id.empty());
      expect(append.pageInfo.hasNextPage, false);
    },
  );

  test(
    "nextPageCursor works",
    () {
      expect(itemsList1.nextPageCursor().pageSize, Cursor.defaultPageSize);
      expect(itemsList1.nextPageCursor().id, itemsList1.pageInfo.nextPageId);
      expect(itemsList1.nextPageCursor().direction, CursorDirection.forward);
    },
  );

  test(
    "previousPageCursor works",
    () {
      expect(itemsList2.previousPageCursor().pageSize, Cursor.defaultPageSize);
      expect(itemsList2.previousPageCursor().id, itemsList2.pageInfo.previousPageId);
      expect(itemsList2.previousPageCursor().direction, CursorDirection.back);
    },
  );
  group("isEmpty", () {
    test("returns true when items are empty and there is NO nextPage", () {
      expect(emptyList.isEmptyNoMorePage, true);
    });

    test("returns false when there are items and there is nextPage", () {
      expect(itemsList1.isEmptyNoMorePage, false);
    });

    test("returns false when there are items and there is NO nextPage", () {
      expect(itemsList2.isEmptyNoMorePage, false);
    });
  });

  group(
    "generic type resolution",
    () {
      User getUser(List<User> users) {
        return users.firstWhere(
          (it) => it.id == Stubs.user.id,
          orElse: () => const User.empty(),
        );
      }

      test('firstWhereOrElse is ok with normal List', () async {
        final participants = List<User>.empty();
        final user = getUser(participants);
        expect(user, const User.empty());
      });

      test('firstWhereOrElse succeeds with PaginatedList', () async {
        const participants = PaginatedList<User>.empty();
        expect(getUser(participants.items), const User.empty());
      });

      test('copyWith properly preserves generic type of the list', () async {
        const participants = PaginatedList<User>.empty();
        final copiedParticipants = participants.copyWith(items: [Stubs.user2]);
        expect(getUser(copiedParticipants.items), const User.empty());
      });
    },
  );
}
