import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/generated_token.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_scoped_pod_token_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetUserScopedPodTokenUseCase useCase;

  setUp(() {
    useCase = GetUserScopedPodTokenUseCase(
      Mocks.podsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.podsRepository.getGeneratedAppToken(podId: any(named: "podId")))
          .thenAnswer((_) => successFuture(const GeneratedToken.empty()));

      // WHEN
      final result = await useCase.execute(podId: const Id('podId'));

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetUserScopedPodTokenUseCase>();
    expect(useCase, isNotNull);
  });
}
