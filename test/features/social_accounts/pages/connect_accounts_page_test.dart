import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_navigator.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_page.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_presentation_model.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_presenter.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_discord_account.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_roblox_account.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_social_accounts.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/social_accounts_mocks.dart';

Future<void> main() async {
  late ConnectAccountsPage page;
  late ConnectAccountsInitialParams initParams;
  late ConnectAccountsPresentationModel model;
  late ConnectAccountsPresenter presenter;
  late ConnectAccountsNavigator navigator;

  void initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => SocialAccountsMocks.getConnectedSocialAccountsUseCase.execute()).thenAnswer(
      (_) => successFuture(
        LinkedSocialAccounts(
          discord: const LinkedDiscordAccount.empty(),
          roblox: const LinkedRobloxAccount.empty().copyWith(
            name: 'roblox-name',
            linkedDate: '19.06.2023',
          ),
          isDiscordLinked: false,
          isRobloxLinked: true,
        ),
      ),
    );
    initParams = const ConnectAccountsInitialParams();
    model = ConnectAccountsPresentationModel.initial(
      initParams,
      Mocks.userStore,
    );
    navigator = ConnectAccountsNavigator(Mocks.appNavigator);
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

    getIt.registerFactoryParam<ConnectAccountsPresenter, ConnectAccountsInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = ConnectAccountsPage(initialParams: initParams);
  }

  await screenshotTest(
    "connect_accounts_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
