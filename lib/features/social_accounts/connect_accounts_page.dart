import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_presentation_model.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_presenter.dart';
import 'package:picnic_app/features/social_accounts/domain/social_network_type.dart';
import 'package:picnic_app/features/social_accounts/widgets/social_account_list_item.dart';
import 'package:picnic_app/features/social_accounts/widgets/unlinked_social_networks.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class ConnectAccountsPage extends StatefulWidget with HasInitialParams {
  const ConnectAccountsPage({
    super.key,
    required this.initialParams,
  });

  @override
  final ConnectAccountsInitialParams initialParams;

  @override
  State<ConnectAccountsPage> createState() => _ConnectAccountsPageState();
}

class _ConnectAccountsPageState extends State<ConnectAccountsPage>
    with PresenterStateMixinAuto<ConnectAccountsViewModel, ConnectAccountsPresenter, ConnectAccountsPage> {
  static const _descriptionContainerRadius = 12.0;
  static const _descriptionMaxNumberOfLines = 4;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final darkBlue = colors.darkBlue;
    final body20 = theme.styles.body20;
    final appBar = PicnicAppBar(
      titleText: appLocalizations.connectAccounts,
    );
    final headlineStyle = theme.styles.link20.copyWith(color: colors.blackAndWhite.shade900);
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: stateObserver(
          builder: (context, state) {
            final discordAccount = state.linkedSocialAccounts.discord;
            final robloxAccount = state.linkedSocialAccounts.roblox;
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_descriptionContainerRadius),
                        color: darkBlue.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appLocalizations.addAccountsToProfile,
                              style: theme.styles.link30.copyWith(color: darkBlue.shade800),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Gap(6),
                            RichText(
                              text: TextSpan(
                                text: appLocalizations.thisInfoWillNotBeShared,
                                style: body20.copyWith(color: darkBlue.shade600),
                                children: [
                                  WidgetSpan(
                                    child: GestureDetector(
                                      onTap: presenter.onTapPrivacyPolicy,
                                      child: Text(
                                        appLocalizations.privacyPolicyLabel,
                                        style: body20.copyWith(
                                          color: colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: _descriptionMaxNumberOfLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    if (state.linkedSocialAccounts.hasAccountsLinked)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalizations.connectedAccounts,
                            style: headlineStyle,
                          ),
                          const Gap(8),
                          if (state.linkedSocialAccounts.isDiscordLinked)
                            SocialAccountListItem(
                              username: discordAccount.username,
                              onTapOpenExternalUrl: () =>
                                  presenter.onTapLinkedSocialNetworkExternalUrl(discordAccount.profileURL),
                              linkedDate: discordAccount.linkedDate,
                              type: SocialNetworkType.discord,
                              onTapUnlinkSocialAccount: presenter.onTapUnlinkDiscordAccount,
                            ),
                          const Gap(8),
                          if (state.linkedSocialAccounts.isRobloxLinked)
                            SocialAccountListItem(
                              username: robloxAccount.name,
                              onTapOpenExternalUrl: () =>
                                  presenter.onTapLinkedSocialNetworkExternalUrl(robloxAccount.profileURL),
                              linkedDate: robloxAccount.linkedDate,
                              type: SocialNetworkType.roblox,
                              onTapUnlinkSocialAccount: presenter.onTapUnlinkRobloxAccount,
                            ),
                        ],
                      ),
                    const Gap(20),
                    if (state.unLinkedSocialNetworkList.isNotEmpty)
                      Expanded(
                        child: UnlinkedSocialNetworks(
                          socialNetworksList: state.unLinkedSocialNetworkList,
                          headlineStyle: headlineStyle,
                          onTapSocialNetwork: presenter.onTapUnLinkedSocialNetwork,
                        ),
                      ),
                  ],
                ),
                if (state.isLoading)
                  const Center(
                    child: PicnicLoadingIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
