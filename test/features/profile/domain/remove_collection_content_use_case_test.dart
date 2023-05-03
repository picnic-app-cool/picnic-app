import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/use_cases/remove_collection_post_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late RemoveCollectionPostUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(postIds: const [Id.empty()], collectionId: const Id.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<RemoveCollectionPostUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    when(
      () => Mocks.collectionsRepository.deletePostsFromCollection(
        postIds: const [Id.empty()],
        collectionId: const Id.empty(),
      ),
    ).thenAnswer((invocation) => successFuture(unit));

    useCase = RemoveCollectionPostUseCase(Mocks.collectionsRepository);
  });
}
