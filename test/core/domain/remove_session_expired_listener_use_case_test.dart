import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/remove_session_expired_listener_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';

void main() {
  late RemoveSessionExpiredListenerUseCase useCase;

  setUp(() {
    useCase = RemoveSessionExpiredListenerUseCase(
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
      verify(() => Mocks.sessionExpiredRepository.removeListener(listener));
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<RemoveSessionExpiredListenerUseCase>();
    expect(useCase, isNotNull);
  });
}
