import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/use_cases/update_app_badge_count_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

void main() {
  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdateAppBadgeCountUseCase>();
    expect(useCase, isNotNull);
  });
}
