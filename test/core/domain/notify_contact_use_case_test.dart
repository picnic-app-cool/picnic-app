import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/notify_contact_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late NotifyContactUseCase useCase;

  setUp(() {
    useCase = NotifyContactUseCase(Mocks.contactsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.contactsRepository.notifyContact(
          entityId: Stubs.id,
          contactId: Stubs.publicProfile.id,
          notifyType: Stubs.inviteFriendNotifyType,
        ),
      ).thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(
        contactId: Stubs.user.id,
        entityId: Stubs.id,
        notifyType: Stubs.inviteFriendNotifyType,
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<NotifyContactUseCase>();
    expect(useCase, isNotNull);
  });
}
