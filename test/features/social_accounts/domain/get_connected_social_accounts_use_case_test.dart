import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_social_accounts.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/get_connected_social_accounts_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetConnectedSocialAccountsUseCase useCase;

  setUp(() {
    useCase = GetConnectedSocialAccountsUseCase(
      Mocks.socialAccountsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.socialAccountsRepository.getConnectedSocialAccounts())
          .thenAnswer((_) => successFuture(const LinkedSocialAccounts.empty()));

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetConnectedSocialAccountsUseCase>();
    expect(useCase, isNotNull);
  });
}
