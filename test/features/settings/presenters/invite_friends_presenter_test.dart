import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_initial_params.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_presentation_model.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/settings_mock_definitions.dart';

void main() {
  late InviteFriendsPresentationModel model;
  late InviteFriendsPresenter presenter;
  late MockInviteFriendsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = InviteFriendsPresentationModel.initial(const InviteFriendsInitialParams(inviteLink: ''));
    navigator = MockInviteFriendsNavigator();

    when(() => Mocks.getContactsUseCase.execute(nextPageCursor: any(named: 'nextPageCursor'), searchQuery: ''))
        .thenAnswer((invocation) => successFuture(Stubs.userContacts));

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
  });
}
