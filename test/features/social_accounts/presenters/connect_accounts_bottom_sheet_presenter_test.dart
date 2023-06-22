import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_presenter.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_sheet_presentation_model.dart';

import '../mocks/social_accounts_mock_definitions.dart';
import '../mocks/social_accounts_mocks.dart';

void main() {
  late ConnectAccountsSheetPresentationModel model;
  late ConnectAccountsBottomSheetPresenter presenter;
  late MockConnectAccountsBottomSheetNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = ConnectAccountsSheetPresentationModel.initial(const ConnectAccountsBottomSheetInitialParams());
    navigator = MockConnectAccountsBottomSheetNavigator();
    presenter = ConnectAccountsBottomSheetPresenter(
      model,
      navigator,
      SocialAccountsMocks.getConnectedSocialAccountsUseCase,
      SocialAccountsMocks.unlinkDiscordAccountUseCase,
      SocialAccountsMocks.unlinkRobloxAccountUseCase,
    );
  });
}
