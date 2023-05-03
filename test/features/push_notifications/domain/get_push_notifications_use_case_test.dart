import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/push_notifications/domain/use_cases/get_push_notifications_use_case.dart';

void main() {
  test("getIt resolves successfully", () async {
    final useCase = getIt<GetPushNotificationsUseCase>();
    expect(useCase, isNotNull);
  });
}
