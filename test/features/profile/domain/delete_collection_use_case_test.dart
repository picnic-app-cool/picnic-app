import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/use_cases/delete_collection_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late DeleteCollectionUseCase useCase;

  setUp(() {
    when(() => Mocks.collectionsRepository.deleteCollection(collectionId: const Id.empty())) //
        .thenAnswer((_) => successFuture(unit));

    useCase = DeleteCollectionUseCase(Mocks.collectionsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(collectionId: const Id.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<DeleteCollectionUseCase>();
    expect(useCase, isNotNull);
  });
}
