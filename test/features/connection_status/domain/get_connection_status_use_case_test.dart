import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/connection_status/domain/use_cases/get_connection_status_use_case.dart';

void main() {
  test("getIt resolves successfully", () async {
    final useCase = getIt<GetConnectionStatusUseCase>();
    expect(useCase, isNotNull);
  });
}
