import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late RequestRuntimePermissionUseCase useCase;

  setUp(() {
    useCase = RequestRuntimePermissionUseCase(Mocks.runtimePermissionsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.runtimePermissionsRepository.requestRuntimePermission(any()))
          .thenAnswer((invocation) => successFuture(RuntimePermissionStatus.granted));

      // WHEN
      final result = await useCase.execute(permission: RuntimePermission.notifications);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<RequestRuntimePermissionUseCase>();
    expect(useCase, isNotNull);
  });
}
