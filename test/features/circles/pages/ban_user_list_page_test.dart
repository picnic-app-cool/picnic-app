import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_navigator.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_page.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_presentation_model.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late BanUserListPage page;
  late BanUserListInitialParams initParams;
  late BanUserListPresentationModel model;
  late BanUserListPresenter presenter;
  late BanUserListNavigator navigator;

  void _initMvp() {
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);

    when(
      () => Mocks.searchUsersUseCase.execute(
        query: any(named: 'query'),
        nextPageCursor: any(named: 'nextPageCursor'),
        ignoreMyself: any(named: 'ignoreMyself'),
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage(
          [
            Stubs.publicProfile,
            Stubs.publicProfile2,
          ],
        ),
      ),
    );
    initParams = BanUserListInitialParams(circle: Stubs.circle);
    model = BanUserListPresentationModel.initial(
      initParams,
    );
    navigator = BanUserListNavigator(Mocks.appNavigator, Mocks.userStore);
    presenter = BanUserListPresenter(
      model,
      navigator,
      CirclesMocks.banUserUseCase,
      Mocks.searchUsersUseCase,
      Mocks.debouncer,
    );

    page = BanUserListPage(presenter: presenter);
  }

  await screenshotTest(
    "ban_user_list_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<BanUserListPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
