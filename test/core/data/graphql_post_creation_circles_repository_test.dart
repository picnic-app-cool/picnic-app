import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/graphql_post_creation_circles_repository.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GraphqlPostCreationCirclesRepository _repository;

  final circle1 = Stubs.circle.copyWith(id: const Id('circle1'));
  final circle2 = Stubs.circle.copyWith(id: const Id('circle2'));
  final circle3 = Stubs.circle.copyWith(id: const Id('circle3'));

  const identicalSearchQuery = 'search query';

  setUp(
    () {
      _repository = GraphqlPostCreationCirclesRepository(
        Mocks.circlesRepository,
      );
    },
  );

  test("getPostCreationCircles() should return user circles first and then non-user circles", () async {
    when(
      () => Mocks.circlesRepository.getUserCircles(
        searchQuery: any(named: 'searchQuery'),
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList.singlePage(
          [circle1],
        ),
      ),
    );
    when(
      () => Mocks.circlesRepository.getCircles(
        searchQuery: any(named: 'searchQuery'),
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList.singlePage(
          [circle2],
        ),
      ),
    );

    final oldUserCircles = _repository.userCircles;
    final oldOtherCircles = _repository.otherCircles;
    // first call should get the first and only page of user circles
    await _repository.getPostCreationCircles(searchQuery: identicalSearchQuery);
    // second identical call should get a first page of other (non-user) circles
    await _repository.getPostCreationCircles(searchQuery: identicalSearchQuery);
    final newUserCircles = _repository.userCircles;
    final newOtherCircles = _repository.otherCircles;

    expect(oldUserCircles != newUserCircles && oldOtherCircles != newOtherCircles, true);
  });

  test("getPostCreationCircles() should not return duplicated circles", () async {
    when(
      () => Mocks.circlesRepository.getUserCircles(
        searchQuery: any(named: 'searchQuery'),
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList.singlePage(
          [circle1, circle2],
        ),
      ),
    );
    when(
      () => Mocks.circlesRepository.getCircles(
        searchQuery: any(named: 'searchQuery'),
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList.singlePage(
          [circle2, circle3],
        ),
      ),
    );

    // first call should get the first and only page of user circles
    await _repository.getPostCreationCircles(searchQuery: identicalSearchQuery);
    // second identical call should get a first page of other (non-user) circles
    await _repository.getPostCreationCircles(searchQuery: identicalSearchQuery);
    final userCircles = _repository.userCircles;
    final otherCircles = _repository.otherCircles;

    expect(userCircles.items.every((element) => otherCircles.items.contains(element)), false);
  });
}
