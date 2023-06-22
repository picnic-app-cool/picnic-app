import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_presentation_model.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/social_accounts_mock_definitions.dart';
import '../mocks/social_accounts_mocks.dart';

void main() {
  late ConnectAccountsPresentationModel model;
  late ConnectAccountsPresenter presenter;
  late MockConnectAccountsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);
    model = ConnectAccountsPresentationModel.initial(const ConnectAccountsInitialParams(), Mocks.userStore);
    navigator = MockConnectAccountsNavigator();
    presenter = ConnectAccountsPresenter(
      model,
      navigator,
      SocialAccountsMocks.linkDiscordAccountUseCase,
      Mocks.userStore,
      SocialAccountsMocks.linkRobloxAccountUseCase,
      SocialAccountsMocks.getConnectedSocialAccountsUseCase,
      SocialAccountsMocks.unlinkDiscordAccountUseCase,
      SocialAccountsMocks.unlinkRobloxAccountUseCase,
      Mocks.environmentConfigProvider,
    );
  });
}
