import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_presenter.dart';

import '../../../mocks/mocks.dart';
import '../mocks/profile_mock_definitions.dart';

void main() {
  late InviteFriendsBottomSheetPresentationModel model;
  late InviteFriendsBottomSheetPresenter presenter;
  late MockInviteFriendsBottomSheetNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = InviteFriendsBottomSheetPresentationModel.initial(
      const InviteFriendsBottomSheetInitialParams(
        shareLink: '',
      ),
    );
    navigator = MockInviteFriendsBottomSheetNavigator();
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
  });
}
