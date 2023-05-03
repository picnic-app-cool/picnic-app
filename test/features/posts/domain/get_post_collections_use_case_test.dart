import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/use_cases/get_collections_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetCollectionsUseCase useCase;

  setUp(() {
    useCase = GetCollectionsUseCase(
      Mocks.collectionsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.collectionsRepository.getCollections(
          nextPageCursor: const Cursor.firstPage(),
          userId: Stubs.id,
        ),
      ).thenAnswer(
        (_) => successFuture(
          Stubs.postCollections,
        ),
      );

      // WHEN
      final result = await useCase.execute(
        userId: Stubs.id,
        nextPageCursor: const Cursor.firstPage(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCollectionsUseCase>();
    expect(useCase, isNotNull);
  });
}
