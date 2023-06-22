import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_roblox_account.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_social_account_request.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/link_roblox_account_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late LinkRobloxAccountUseCase useCase;

  setUp(() {
    registerFallbackValue(const LinkSocialAccountRequest.empty());
    useCase = LinkRobloxAccountUseCase(
      Mocks.socialAccountsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.socialAccountsRepository.linkRobloxAccount(any()))
          .thenAnswer((_) => successFuture(const LinkedRobloxAccount.empty()));

      // WHEN
      final result = await useCase.execute(
        linkSocialAccountRequest: const LinkSocialAccountRequest.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<LinkRobloxAccountUseCase>();
    expect(useCase, isNotNull);
  });
}
