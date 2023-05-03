import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_initial_params.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_navigator.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_page.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_presentation_model.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';

Future<void> main() async {
  late AddMembersListPage page;
  late AddMembersListInitialParams initParams;
  late AddMembersListPresentationModel model;
  late AddMembersListPresenter presenter;
  late AddMembersListNavigator navigator;

  void _initMvp() {
    initParams = AddMembersListInitialParams(
      onAddUser: (_) async {
        return true;
      },
    );
    model = AddMembersListPresentationModel.initial(
      initParams,
    );
    navigator = AddMembersListNavigator(Mocks.appNavigator);
    presenter = AddMembersListPresenter(
      model,
      navigator,
      Mocks.searchUsersUseCase,
      Mocks.debouncer,
    );
    page = AddMembersListPage(presenter: presenter);
  }

  await screenshotTest(
    "add_members_list_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "add_members_list_one_member_added_page",
    setUp: () async {
      _initMvp();
      await presenter.loadMore();
      await presenter.onTapAdd(Stubs.publicProfile);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<AddMembersListPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });

  setUp(() {
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
  });
}
