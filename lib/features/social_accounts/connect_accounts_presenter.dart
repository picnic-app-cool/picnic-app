//ignore_for_file: forbidden_import_in_presentation
import 'package:bloc/bloc.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/environment_config/environment_config.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_navigator.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_presentation_model.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_social_account_request.dart';
import 'package:picnic_app/features/social_accounts/domain/social_network.dart';
import 'package:picnic_app/features/social_accounts/domain/social_network_type.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/get_connected_social_accounts_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/link_discord_account_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/link_roblox_account_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/unlink_discord_account_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/unlink_roblox_account_use_case.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class ConnectAccountsPresenter extends Cubit<ConnectAccountsViewModel> with SubscriptionsMixin {
  ConnectAccountsPresenter(
    super.model,
    this._navigator,
    this._linkDiscordAccountUseCase,
    this._userStore,
    this._linkRobloxAccountUseCase,
    this._getConnectedSocialAccountsUseCase,
    this._unlinkDiscordAccountUseCase,
    this._unlinkRobloxAccountUseCase,
    this._envConfigProvider,
  ) {
    listenTo<PrivateProfile>(
      stream: _userStore.stream,
      subscriptionId: _userStoreSubscription,
      onChange: (user) {
        tryEmit(_model.copyWith(user: user));
      },
    );
  }

  static const _userStoreSubscription = "socialConnectedAccountsUserStoreSubscription";

  final ConnectAccountsNavigator _navigator;
  final LinkDiscordAccountUseCase _linkDiscordAccountUseCase;
  final LinkRobloxAccountUseCase _linkRobloxAccountUseCase;
  final UserStore _userStore;
  final GetConnectedSocialAccountsUseCase _getConnectedSocialAccountsUseCase;
  final UnlinkDiscordAccountUseCase _unlinkDiscordAccountUseCase;
  final UnlinkRobloxAccountUseCase _unlinkRobloxAccountUseCase;
  final EnvironmentConfigProvider _envConfigProvider;

  // ignore: unused_element
  ConnectAccountsPresentationModel get _model => state as ConnectAccountsPresentationModel;

  Future<void> onInit() async {
    await _loadSocialAccounts();
  }

  void onTapPrivacyPolicy() {
    _navigator.openUrl(Constants.policiesUrl);
  }

  Future<void> onTapUnLinkedSocialNetwork(SocialNetwork socialAccount) async {
    if (socialAccount.type == SocialNetworkType.discord) {
      await _linkDiscord();
      await _loadSocialAccounts();
    } else if (socialAccount.type == SocialNetworkType.roblox) {
      await _linkRoblox();
      await _loadSocialAccounts();
    }
  }

  void onTapLinkedSocialNetworkExternalUrl(String profileURL) => _navigator.openUrl(profileURL);

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
          fail: (fail) => _navigator.showError(fail.displayableFailure()),
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
          fail: (fail) => _navigator.showError(fail.displayableFailure()),
        );
  }

  //ignore: long-method
  Future<void> _loadSocialAccounts() => _getConnectedSocialAccountsUseCase
      .execute()
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(getLinkedAccountsResult: result)),
      )
      .doOn(
        fail: (fail) => _navigator.showError(fail.displayableFailure()),
        success: (linkedSocialAccounts) {
          final unLinkedSocialNetworks = <SocialNetwork>[];
          if (!linkedSocialAccounts.isDiscordLinked) {
            unLinkedSocialNetworks.add(
              SocialNetwork(
                assetImagePath: Assets.images.discordSocialNetwork.path,
                type: SocialNetworkType.discord,
              ),
            );
          }
          if (!linkedSocialAccounts.isRobloxLinked) {
            unLinkedSocialNetworks.add(
              SocialNetwork(
                assetImagePath: Assets.images.roblox.path,
                type: SocialNetworkType.roblox,
              ),
            );
          }
          tryEmit(
            _model.copyWith(
              linkedSocialAccounts: linkedSocialAccounts,
              unLinkedSocialNetworkList: PaginatedList.singlePage(unLinkedSocialNetworks),
            ),
          );
        },
      );

  Future<void> _linkDiscord() async {
    final config = await _envConfigProvider.getConfig();
    final code = await _getDiscordToken(config);
    await _linkDiscordAccountUseCase
        .execute(
          linkSocialAccountRequest: LinkSocialAccountRequest(
            code: code,
            redirectUri: config.discordRedirectUrl,
          ),
        )
        .doOn(
          success: (linkedAccount) {
            _showSuccessBottomSheet(
              username: linkedAccount.username,
              type: SocialNetworkType.discord,
              profileURL: linkedAccount.profileURL,
              linkedDate: linkedAccount.linkedDate,
            );
          },
          fail: (fail) => _navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> _linkRoblox() async {
    final config = await _envConfigProvider.getConfig();
    final code = await _getRobloxToken(config);
    await _linkRobloxAccountUseCase
        .execute(
          linkSocialAccountRequest: LinkSocialAccountRequest(
            code: code,
            redirectUri: config.robloxRedirectUrl,
          ),
        )
        .doOn(
          success: (linkedAccount) {
            _showSuccessBottomSheet(
              username: linkedAccount.name,
              type: SocialNetworkType.roblox,
              profileURL: linkedAccount.profileURL,
              linkedDate: linkedAccount.linkedDate,
            );
          },
          fail: (fail) => _navigator.showError(fail.displayableFailure()),
        );
  }

  Future<void> _showSuccessBottomSheet({
    required String username,
    required SocialNetworkType type,
    required String profileURL,
    required String linkedDate,
  }) {
    return _navigator.showLinkSocialAccountSuccessBottomSheet(
      username: username,
      socialNetworkType: type,
      linkedDate: linkedDate,
      picnicUserImageUrl: _model.user.profileImageUrl.url,
      onTapOpenExternalUrl: () => onTapLinkedSocialNetworkExternalUrl(profileURL),
    );
  }

  Future<String> _getRobloxToken(EnvironmentConfig config) async {
    const _customUriScheme = "https";

    final url = Uri.https(
      'authorize.roblox.com',
      '',
      {
        'client_id': config.robloxClientId,
        'redirect_uri': config.robloxRedirectUrl,
        'grant_type': 'authorization_code',
        'response_type': 'Code',
        'prompts': 'login consent',
        'scope': 'openid universe-messaging-service:publish profile asset:read asset:write',
      },
    );

    final result = await FlutterWebAuth2.authenticate(
      url: url.toString(),
      callbackUrlScheme: _customUriScheme,
    );

    var urlCode = Uri.parse(result);
    var code = urlCode.queryParameters['code'] ?? "";
    return code;
  }

  Future<String> _getDiscordToken(EnvironmentConfig config) async {
    const _customUriScheme = "https";

    final url = Uri.https(
      'discord.com',
      '/api/oauth2/authorize',
      {
        'client_id': config.discordClientId,
        'redirect_uri': config.discordRedirectUrl,
        'strictDiscoveryDocumentValidation': 'false',
        'grant_type': 'authorization_code',
        'oidc': 'false',
        'response_type': 'code',
        'disablePKCE': 'true',
        'scope': 'identify',
      },
    );

    final result = await FlutterWebAuth2.authenticate(
      url: url.toString(),
      callbackUrlScheme: _customUriScheme,
    );

    var urlCode = Uri.parse(result);
    var code = urlCode.queryParameters['code'] ?? "";
    return code;
  }
}
