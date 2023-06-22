import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/future_result.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_social_accounts.dart';
import 'package:picnic_app/features/social_accounts/domain/model/get_connected_social_accounts_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_discord_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_roblox_account_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ConnectAccountsSheetPresentationModel implements ConnectAccountsBottomSheetViewModel {
  /// Creates the initial state
  ConnectAccountsSheetPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ConnectAccountsBottomSheetInitialParams initialParams,
  )   : linkedSocialAccounts = const LinkedSocialAccounts.empty(),
        unlinkDiscordResult = const FutureResult.empty(),
        unlinkRobloxResult = const FutureResult.empty(),
        getLinkedAccountsResult = const FutureResult.empty();

  /// Used for the copyWith method
  ConnectAccountsSheetPresentationModel._({
    required this.linkedSocialAccounts,
    required this.unlinkDiscordResult,
    required this.unlinkRobloxResult,
    required this.getLinkedAccountsResult,
  });

  @override
  final LinkedSocialAccounts linkedSocialAccounts;

  final FutureResult<Either<UnlinkDiscordAccountFailure, Unit>> unlinkDiscordResult;
  final FutureResult<Either<UnlinkRobloxAccountFailure, Unit>> unlinkRobloxResult;
  final FutureResult<Either<GetConnectedSocialAccountsFailure, LinkedSocialAccounts>> getLinkedAccountsResult;

  @override
  bool get isLoading =>
      unlinkDiscordResult.isPending() || unlinkRobloxResult.isPending() || getLinkedAccountsResult.isPending();

  ConnectAccountsSheetPresentationModel copyWith({
    LinkedSocialAccounts? linkedSocialAccounts,
    FutureResult<Either<UnlinkDiscordAccountFailure, Unit>>? unlinkDiscordResult,
    FutureResult<Either<UnlinkRobloxAccountFailure, Unit>>? unlinkRobloxResult,
    FutureResult<Either<GetConnectedSocialAccountsFailure, LinkedSocialAccounts>>? getLinkedAccountsResult,
  }) {
    return ConnectAccountsSheetPresentationModel._(
      linkedSocialAccounts: linkedSocialAccounts ?? this.linkedSocialAccounts,
      unlinkDiscordResult: unlinkDiscordResult ?? this.unlinkDiscordResult,
      unlinkRobloxResult: unlinkRobloxResult ?? this.unlinkRobloxResult,
      getLinkedAccountsResult: getLinkedAccountsResult ?? this.getLinkedAccountsResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ConnectAccountsBottomSheetViewModel {
  LinkedSocialAccounts get linkedSocialAccounts;
  bool get isLoading;
}
