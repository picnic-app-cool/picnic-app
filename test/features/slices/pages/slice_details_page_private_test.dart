import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_initial_params.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_navigator.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_page.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_presentation_model.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';

Future<void> main() async {
  //ignore: unused_local_variable
  late SliceDetailsPage page;
  late SliceDetailsInitialParams initParams;
  late SliceDetailsPresentationModel model;
  late SliceDetailsPresenter presenter;
  late SliceDetailsNavigator navigator;

  void _initMvp() {
    initParams = SliceDetailsInitialParams(
      circle: Stubs.circle,
      slice: Stubs.slice.copyWith(private: true),
    );
    model = SliceDetailsPresentationModel.initial(
      initParams,
    );
    navigator = SliceDetailsNavigator(Mocks.appNavigator, Mocks.userStore);
    presenter = SliceDetailsPresenter(
      model,
      Mocks.getSliceMemberByRoleUseCase,
      navigator,
      Mocks.clipboardManager,
      Mocks.debouncer,
    );

    when(
      () => Mocks.getSliceMemberByRoleUseCase.execute(
        nextPageCursor: const Cursor.firstPage(),
        sliceId: Stubs.slice.id,
        roles: [
          SliceRole.owner,
          SliceRole.director,
          SliceRole.moderator,
        ],
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList(
          pageInfo: const PageInfo.empty(),
          items: [
            Stubs.sliceMemberDirector,
            Stubs.sliceMemberModerator,
          ],
        ),
      ),
    );

    when(
      () => Mocks.getSliceMemberByRoleUseCase.execute(
        nextPageCursor: const Cursor.firstPage(),
        sliceId: Stubs.slice.id,
        roles: [
          SliceRole.member,
        ],
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList(
          pageInfo: const PageInfo.empty(),
          items: [
            Stubs.sliceMember,
          ],
        ),
      ),
    );

    page = SliceDetailsPage(presenter: presenter);
  }

  await screenshotTest(
    "slice_details_page_private_test",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SliceDetailsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
