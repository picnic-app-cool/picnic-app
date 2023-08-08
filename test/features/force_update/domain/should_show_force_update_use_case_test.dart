import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/force_update/domain/use_case/should_show_force_update_use_case.dart';

import '../../../domain/app_version.dart';
import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/force_update_mocks.dart';

void main() {
  late ShouldShowForceUpdateUseCase useCase;

  setUp(() {
    when(() => Mocks.appInfoStore.appInfo).thenReturn(Stubs.appInfo);
    when(() => Mocks.setAppInfoUseCase.execute()).thenAnswer((_) => successFuture(unit));

    useCase = ShouldShowForceUpdateUseCase(
      ForceUpdateMocks.getMinAppVersionUseCase,
      Mocks.appInfoStore,
      Mocks.setAppInfoUseCase,
    );
  });

  final inputWithExpectedValidation = <AppVersion, bool>{
    AppVersion(
      minAppVersion: '1.2.3',
      appInfo: Stubs.appInfo.copyWith(buildNumber: '1.2.4'),
    ): false,
    AppVersion(
      minAppVersion: '4.3.2',
      appInfo: Stubs.appInfo.copyWith(
        buildNumber: '3.1.4',
      ),
    ): true,
    AppVersion(
      minAppVersion: '1.2.2',
      appInfo: Stubs.appInfo.copyWith(
        buildNumber: '2.1.4',
      ),
    ): false,
    AppVersion(
      minAppVersion: '1.1.1',
      appInfo: Stubs.appInfo.copyWith(
        buildNumber: '2.1.5',
      ),
    ): false,
    AppVersion(
      minAppVersion: '1.0.0',
      appInfo: Stubs.appInfo.copyWith(
        buildNumber: '2.1.8',
      ),
    ): false,
    AppVersion(
      minAppVersion: '4.3.1',
      appInfo: Stubs.appInfo.copyWith(
        buildNumber: '3.1.2',
      ),
    ): true
  };

  inputWithExpectedValidation.forEach((input, validation) {
    test("should validate the usecase output by comparing with expected validation states for input", () async {
      when(() => ForceUpdateMocks.getMinAppVersionUseCase.execute())
          .thenAnswer((invocation) => successFuture(input.minAppVersion));

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result, validation);
    });
  });

  test("getIt resolves successfully", () async {
    final useCase = getIt<ShouldShowForceUpdateUseCase>();
    expect(useCase, isNotNull);
  });
}
