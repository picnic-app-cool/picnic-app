import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/add_session_expired_listener_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';

void main() {
  late AddSessionExpiredListenerUseCase useCase;

  setUp(() {
    useCase = AddSessionExpiredListenerUseCase(
      Mocks.sessionExpiredRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      void listener() {}

      // WHEN
      useCase.execute(listener);

      // THEN
      verify(() => Mocks.sessionExpiredRepository.addListener(listener));
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<AddSessionExpiredListenerUseCase>();
    expect(useCase, isNotNull);
  });
}
