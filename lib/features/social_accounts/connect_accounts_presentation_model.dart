import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/future_result.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_initial_params.dart';
import 'package:picnic_app/features/social_accounts/domain/linked_social_accounts.dart';
import 'package:picnic_app/features/social_accounts/domain/model/get_connected_social_accounts_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_discord_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_roblox_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/social_network.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ConnectAccountsPresentationModel implements ConnectAccountsViewModel {
  /// Creates the initial state
  ConnectAccountsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ConnectAccountsInitialParams initialParams,
    UserStore userStore,
  )   : user = userStore.privateProfile,
        linkedSocialAccounts = const LinkedSocialAccounts.empty(),
        unLinkedSocialNetworkList = const PaginatedList.empty(),
        unlinkDiscordResult = const FutureResult.empty(),
        unlinkRobloxResult = const FutureResult.empty(),
        getLinkedAccountsResult = const FutureResult.empty();

  /// Used for the copyWith method
  ConnectAccountsPresentationModel._({
    required this.user,
    required this.linkedSocialAccounts,
    required this.unLinkedSocialNetworkList,
    required this.unlinkDiscordResult,
    required this.unlinkRobloxResult,
    required this.getLinkedAccountsResult,
  });

  @override
  final PrivateProfile user;

  @override
  final LinkedSocialAccounts linkedSocialAccounts;

  @override
  final PaginatedList<SocialNetwork> unLinkedSocialNetworkList;

  final FutureResult<Either<UnlinkDiscordAccountFailure, Unit>> unlinkDiscordResult;
  final FutureResult<Either<UnlinkRobloxAccountFailure, Unit>> unlinkRobloxResult;
  final FutureResult<Either<GetConnectedSocialAccountsFailure, LinkedSocialAccounts>> getLinkedAccountsResult;

  @override
  bool get isLoading =>
      unlinkDiscordResult.isPending() || unlinkRobloxResult.isPending() || getLinkedAccountsResult.isPending();

  ConnectAccountsPresentationModel copyWith({
    PrivateProfile? user,
    LinkedSocialAccounts? linkedSocialAccounts,
    PaginatedList<SocialNetwork>? unLinkedSocialNetworkList,
    FutureResult<Either<UnlinkDiscordAccountFailure, Unit>>? unlinkDiscordResult,
    FutureResult<Either<UnlinkRobloxAccountFailure, Unit>>? unlinkRobloxResult,
    FutureResult<Either<GetConnectedSocialAccountsFailure, LinkedSocialAccounts>>? getLinkedAccountsResult,
  }) {
    return ConnectAccountsPresentationModel._(
      user: user ?? this.user,
      linkedSocialAccounts: linkedSocialAccounts ?? this.linkedSocialAccounts,
      unLinkedSocialNetworkList: unLinkedSocialNetworkList ?? this.unLinkedSocialNetworkList,
      unlinkDiscordResult: unlinkDiscordResult ?? this.unlinkDiscordResult,
      unlinkRobloxResult: unlinkRobloxResult ?? this.unlinkRobloxResult,
      getLinkedAccountsResult: getLinkedAccountsResult ?? this.getLinkedAccountsResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ConnectAccountsViewModel {
  PaginatedList<SocialNetwork> get unLinkedSocialNetworkList;

  PrivateProfile get user;

  LinkedSocialAccounts get linkedSocialAccounts;

  bool get isLoading;
}
