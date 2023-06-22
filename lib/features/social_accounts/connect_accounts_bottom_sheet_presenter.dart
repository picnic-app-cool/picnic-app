import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_sheet_presentation_model.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/get_connected_social_accounts_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/unlink_discord_account_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/unlink_roblox_account_use_case.dart';

class ConnectAccountsBottomSheetPresenter extends Cubit<ConnectAccountsBottomSheetViewModel> {
  ConnectAccountsBottomSheetPresenter(
    super.model,
    this.navigator,
    this._getConnectedSocialAccountsUseCase,
    this._unlinkDiscordAccountUseCase,
    this._unlinkRobloxAccountUseCase,
  );

  final ConnectAccountsBottomSheetNavigator navigator;
  final GetConnectedSocialAccountsUseCase _getConnectedSocialAccountsUseCase;
  final UnlinkDiscordAccountUseCase _unlinkDiscordAccountUseCase;
  final UnlinkRobloxAccountUseCase _unlinkRobloxAccountUseCase;

  // ignore: unused_element
  ConnectAccountsSheetPresentationModel get _model => state as ConnectAccountsSheetPresentationModel;

  Future<void> onInit() async {
    await _loadSocialAccounts();
  }

  Future<void> onTapConnectAccounts() async {
    await navigator.openConnectAccounts(const ConnectAccountsInitialParams());
    await _loadSocialAccounts();
  }

  Future<void> onTapUnlinkDiscordAccount() async {
    await _unlinkDiscordAccountUseCase
        .execute()
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(unlinkDiscordResult: result)),
        )
        .doOn(
          success: (_) {
            _loadSocialAccounts();
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> onTapUnlinkRobloxAccount() async {
    await _unlinkRobloxAccountUseCase
        .execute()
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(unlinkRobloxResult: result)),
        )
        .doOn(
          success: (_) {
            _loadSocialAccounts();
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onTapSocialNetworkExternalUrl(String profileURL) {
    navigator.openUrl(profileURL);
  }

  Future<void> _loadSocialAccounts() => _getConnectedSocialAccountsUseCase
      .execute()
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(getLinkedAccountsResult: result)),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (linkedSocialAccounts) => tryEmit(
          _model.copyWith(
            linkedSocialAccounts: linkedSocialAccounts,
          ),
        ),
      );
}
