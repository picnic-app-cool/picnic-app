import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/unlink_discord_account_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late UnlinkDiscordAccountUseCase useCase;

  setUp(() {
    useCase = UnlinkDiscordAccountUseCase(
      Mocks.socialAccountsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.socialAccountsRepository.unlinkDiscordAccount()).thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UnlinkDiscordAccountUseCase>();
    expect(useCase, isNotNull);
  });
}
