import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_initial_params.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_navigator.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_page.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_presentation_model.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late BannedUsersPage page;
  late BannedUsersInitialParams initParams;
  late BannedUsersPresentationModel model;
  late BannedUsersPresenter presenter;
  late BannedUsersNavigator navigator;

  void initMvp() {
    when(
      () => CirclesMocks.getBannedUsersUseCase.execute(
        circleId: Stubs.circle.id,
        cursor: any(named: 'cursor'),
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage([
          Stubs.permanentBannedUser,
          Stubs.temporaryBannedUser,
        ]),
      ),
    );
    initParams = BannedUsersInitialParams(circle: Stubs.circle);
    final time = Stubs.dateTime.subtract(const Duration(hours: 7));
    when(() => Mocks.currentTimeProvider.currentTime).thenAnswer((_) => time);
    model = BannedUsersPresentationModel.initial(
      initParams,
      Mocks.currentTimeProvider,
    );
    navigator = BannedUsersNavigator(Mocks.appNavigator, Mocks.userStore);
    presenter = BannedUsersPresenter(
      model,
      navigator,
      CirclesMocks.unbanUserUseCase,
      CirclesMocks.getBannedUsersUseCase,
    );
    page = BannedUsersPage(presenter: presenter);
  }

  await screenshotTest(
    "banned_users_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<BannedUsersPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
