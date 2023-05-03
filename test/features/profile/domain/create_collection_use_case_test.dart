import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/model/create_collection_input.dart';
import 'package:picnic_app/features/profile/domain/use_cases/create_collection_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late CreateCollectionUseCase useCase;

  setUp(() {
    registerFallbackValue(const CreateCollectionInput.empty());
    useCase = CreateCollectionUseCase(Mocks.collectionsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.collectionsRepository.createCollection(createCollectionInput: any(named: 'createCollectionInput')),
      ).thenAnswer((_) => successFuture(Stubs.collection));

      // WHEN
      final result = await useCase.execute(const CreateCollectionInput(title: 'collection name'));

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<CreateCollectionUseCase>();
    expect(useCase, isNotNull);
  });
}
