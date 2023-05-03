import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/in_app_events/domain/use_cases/get_in_app_notifications_use_case.dart';

void main() {
  test("getIt resolves successfully", () async {
    final useCase = getIt<GetInAppNotificationsUseCase>();
    expect(useCase, isNotNull);
  });
}
