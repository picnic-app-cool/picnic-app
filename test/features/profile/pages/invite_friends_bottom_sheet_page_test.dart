import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_page.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';

Future<void> main() async {
  late InviteFriendsBottomSheetPage page;
  late InviteFriendsBottomSheetInitialParams initParams;
  late InviteFriendsBottomSheetPresentationModel model;
  late InviteFriendsBottomSheetPresenter presenter;
  late InviteFriendsBottomSheetNavigator navigator;

  void initMvp() {
    initParams = const InviteFriendsBottomSheetInitialParams(shareLink: '');
    model = InviteFriendsBottomSheetPresentationModel.initial(
      initParams,
    );
    navigator = InviteFriendsBottomSheetNavigator(Mocks.appNavigator);
    presenter = InviteFriendsBottomSheetPresenter(
      model,
      navigator,
      Mocks.getContactsUseCase,
      Mocks.notifyContactUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.getPhoneContactsUseCase,
      Mocks.debouncer,
    );
    when(
      () => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.contacts),
    ).thenAnswer((invocation) => successFuture(RuntimePermissionStatus.denied));
    when(
      () => Mocks.getContactsUseCase.execute(
        searchQuery: '',
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer(
      (_) => successFuture(
        Stubs.userContacts,
      ),
    );
    when(
      () => Mocks.getPhoneContactsUseCase.execute(),
    ).thenAnswer(
      (_) => Future.value(Stubs.phoneContacts),
    );
    page = InviteFriendsBottomSheetPage(presenter: presenter);
  }

  await screenshotTest(
    "invite_friends_bottom_sheet_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<InviteFriendsBottomSheetPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
