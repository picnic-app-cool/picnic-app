import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_initial_params.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_navigator.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_page.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_presentation_model.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/settings_mocks.dart';

Future<void> main() async {
  late BlockedListPage page;
  late BlockedListInitialParams initParams;
  late BlockedListPresentationModel model;
  late BlockedListPresenter presenter;
  late BlockedListNavigator navigator;

  void _initMvp() {
    initParams = const BlockedListInitialParams();
    model = BlockedListPresentationModel.initial(
      initParams,
    );
    navigator = BlockedListNavigator(Mocks.appNavigator, Mocks.userStore);
    presenter = BlockedListPresenter(
      model,
      navigator,
      SettingsMocks.getBlockListUseCase,
      Mocks.blockUserUseCase,
      Mocks.unblockUserUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );

    when(() => SettingsMocks.getBlockListUseCase.execute(cursor: const Cursor.firstPage())).thenAnswer(
      (_) => successFuture(
        PaginatedList(
          items: [Stubs.publicProfile, Stubs.publicProfile],
          pageInfo: const PageInfo.empty(),
        ),
      ),
    );

    page = BlockedListPage(presenter: presenter);
  }

  await screenshotTest(
    "blocked_list_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<BlockedListPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
