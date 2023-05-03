import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_initial_params.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_navigator.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_page.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_presentation_model.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';

Future<void> main() async {
  late InviteFriendsPage page;
  late InviteFriendsInitialParams initParams;
  late InviteFriendsPresentationModel model;
  late InviteFriendsPresenter presenter;
  late InviteFriendsNavigator navigator;

  void initMvp() {
    initParams = const InviteFriendsInitialParams(inviteLink: '');
    model = InviteFriendsPresentationModel.initial(
      initParams,
    );
    navigator = InviteFriendsNavigator(Mocks.appNavigator);
    presenter = InviteFriendsPresenter(
      model,
      navigator,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.getContactsUseCase,
      Mocks.notifyContactUseCase,
      Mocks.getPhoneContactsUseCase,
      Mocks.debouncer,
    );

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
    page = InviteFriendsPage(presenter: presenter);
  }

  await screenshotTest(
    "invite_friends_pagess",
    variantName: "contact_permission_denied",
    setUp: () async {
      when(() => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.contacts))
          .thenAnswer((invocation) => successFuture(RuntimePermissionStatus.denied));
      initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "invite_friends_page",
    variantName: "contact_permission_granted",
    setUp: () async {
      when(() => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.contacts))
          .thenAnswer((invocation) => successFuture(RuntimePermissionStatus.granted));
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<InviteFriendsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
