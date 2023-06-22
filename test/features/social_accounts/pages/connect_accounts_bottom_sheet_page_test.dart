import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_page.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_presenter.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_sheet_presentation_model.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_discord_account.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_roblox_account.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_social_accounts.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/social_accounts_mocks.dart';

Future<void> main() async {
  late ConnectAccountsBottomSheetPage page;
  late ConnectAccountsBottomSheetInitialParams initParams;
  late ConnectAccountsSheetPresentationModel model;
  late ConnectAccountsBottomSheetPresenter presenter;
  late ConnectAccountsBottomSheetNavigator navigator;

  void initMvp() {
    when(() => SocialAccountsMocks.getConnectedSocialAccountsUseCase.execute()).thenAnswer(
      (_) => successFuture(
        LinkedSocialAccounts(
          discord: const LinkedDiscordAccount.empty().copyWith(
            username: 'discordUsername',
            linkedDate: '19.06.2023',
          ),
          roblox: const LinkedRobloxAccount.empty(),
          isDiscordLinked: true,
          isRobloxLinked: false,
        ),
      ),
    );

    initParams = const ConnectAccountsBottomSheetInitialParams();
    model = ConnectAccountsSheetPresentationModel.initial(
      initParams,
    );
    navigator = ConnectAccountsBottomSheetNavigator(Mocks.appNavigator);
    presenter = ConnectAccountsBottomSheetPresenter(
      model,
      navigator,
      SocialAccountsMocks.getConnectedSocialAccountsUseCase,
      SocialAccountsMocks.unlinkDiscordAccountUseCase,
      SocialAccountsMocks.unlinkRobloxAccountUseCase,
    );

    getIt.registerFactoryParam<ConnectAccountsBottomSheetPresenter, ConnectAccountsBottomSheetInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = ConnectAccountsBottomSheetPage(
      presenter: presenter,
    );
  }

  await screenshotTest(
    "connect_accounts_bottom_sheet_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
