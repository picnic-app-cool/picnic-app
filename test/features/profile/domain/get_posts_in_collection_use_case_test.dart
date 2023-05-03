import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_posts_in_collection_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetPostsInCollectionUseCase useCase;

  setUp(() {
    when(
      () => Mocks.collectionsRepository.getPostsInCollection(
        nextPageCursor: any(named: 'nextPageCursor'),
        collectionId: any(named: 'collectionId'),
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.empty()));

    useCase = GetPostsInCollectionUseCase(Mocks.collectionsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        collectionId: const Id.empty(),
        nextPageCursor: const Cursor.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetPostsInCollectionUseCase>();
    expect(useCase, isNotNull);
  });
}
