import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags_defaults.dart';
import 'package:picnic_app/core/domain/repositories/secure_local_storage_repository.dart';
import 'package:picnic_app/core/environment_config/debug_environment_config_provider.dart';

import '../mocks/mocks.dart';
import '../test_utils/test_utils.dart';

void main() {
  final provider = DebugEnvironmentConfigProvider(
    const FeatureFlagsDefaults(),
  );
  test("reading invalid headers should return empty map", () async {
    reRegister<SecureLocalStorageRepository>(Mocks.secureLocalStoreRepository);
    when(() => Mocks.secureLocalStoreRepository.read<String>(key: any(named: 'key'))) //
        .thenSuccess((_) => "invalid json !!");
    final headers = await provider.getAdditionalGraphQLHeaders();
    expect(headers, {});
  });
}
