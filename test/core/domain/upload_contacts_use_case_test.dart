import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/upload_contacts_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late UploadContactsUseCase useCase;

  setUp(() {
    useCase = UploadContactsUseCase(
      Mocks.contactsRepository,
    );

    when(() => Mocks.contactsRepository.getContacts()).thenAnswer(
      (_) => Future.value(Stubs.phoneContacts),
    );

    when(() => Mocks.contactsRepository.uploadContacts(contacts: any(named: 'contacts'))).thenAnswer(
      (_) => successFuture(unit),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UploadContactsUseCase>();
    expect(useCase, isNotNull);
  });
}
