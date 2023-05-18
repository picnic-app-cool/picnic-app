import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/vote_director_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late VoteDirectorUseCase useCase;
  const id = Id.empty();

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(circleId: id, userId: id);
      verify(() => Mocks.seedsRepository.voteDirector(userId: id, circleId: id));

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<VoteDirectorUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = VoteDirectorUseCase(Mocks.seedsRepository);

    when(() => Mocks.seedsRepository.voteDirector(userId: id, circleId: id)) //
        .thenAnswer((_) => successFuture(id));

    when(() => SeedsMocks.voteDirectorUseCase.execute(userId: id, circleId: id)).thenAnswer((_) => successFuture(id));
  });
}
