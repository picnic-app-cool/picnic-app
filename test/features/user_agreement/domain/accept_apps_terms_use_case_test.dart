import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/user_agreement/domain/use_cases/accept_apps_terms_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late AcceptAppsTermsUseCase useCase;

  setUp(() {
    useCase = AcceptAppsTermsUseCase(Mocks.userPreferencesRepository);
  });

  test(
    'use case executes normally',
    () async {
      when(() => Mocks.userPreferencesRepository.acceptAppTerms()).thenSuccess((_) => true);

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.getSuccess(), true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<AcceptAppsTermsUseCase>();
    expect(useCase, isNotNull);
  });
}
