import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/profile/private_profile/widgets/profile_horizontal_item.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_presenter.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_sheet_presentation_model.dart';
import 'package:picnic_app/features/social_accounts/domain/social_network_type.dart';
import 'package:picnic_app/features/social_accounts/widgets/no_social_accounts_linked.dart';
import 'package:picnic_app/features/social_accounts/widgets/social_account_list_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/bottom_sheet_top_indicator.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class ConnectAccountsBottomSheetPage extends StatefulWidget with HasPresenter<ConnectAccountsBottomSheetPresenter> {
  const ConnectAccountsBottomSheetPage({
    super.key,
    required this.presenter,
  });

  @override
  final ConnectAccountsBottomSheetPresenter presenter;

  @override
  State<ConnectAccountsBottomSheetPage> createState() => _ConnectAccountsBottomSheetPageState();
}

class _ConnectAccountsBottomSheetPageState extends State<ConnectAccountsBottomSheetPage>
    with
        PresenterStateMixin<ConnectAccountsBottomSheetViewModel, ConnectAccountsBottomSheetPresenter,
            ConnectAccountsBottomSheetPage> {
  static const _plusIconSize = 18.0;
  static const _noAccountsLinkedHeightFactor = 0.35;
  static const _accountsLinkedFactor = 0.5;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    return stateObserver(
      builder: (context, state) => FractionallySizedBox(
        heightFactor:
            state.linkedSocialAccounts.hasAccountsLinked ? _accountsLinkedFactor : _noAccountsLinkedHeightFactor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: stateObserver(
            builder: (context, state) {
              final discordAccount = state.linkedSocialAccounts.discord;
              final robloxAccount = state.linkedSocialAccounts.roblox;
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            BottomSheetTopIndicator(),
                            const Gap(16),
                            if (!state.linkedSocialAccounts.hasAccountsLinked) NoSocialAccountsLinked(),
                            ProfileHorizontalItem(
                              onTap: presenter.onTapConnectAccounts,
                              title: appLocalizations.connectAccounts,
                              trailing: Image.asset(
                                Assets.images.add.path,
                                color: colors.darkBlue.shade800,
                                height: _plusIconSize,
                                width: _plusIconSize,
                              ),
                            ),
                            const Gap(16),
                            if (state.linkedSocialAccounts.isDiscordLinked)
                              SocialAccountListItem(
                                username: discordAccount.username,
                                onTapOpenExternalUrl: () =>
                                    presenter.onTapSocialNetworkExternalUrl(discordAccount.profileURL),
                                linkedDate: discordAccount.linkedDate,
                                type: SocialNetworkType.discord,
                                onTapUnlinkSocialAccount: presenter.onTapUnlinkDiscordAccount,
                              ),
                            const Gap(8),
                            if (state.linkedSocialAccounts.isRobloxLinked)
                              SocialAccountListItem(
                                username: robloxAccount.name,
                                onTapOpenExternalUrl: () =>
                                    presenter.onTapSocialNetworkExternalUrl(robloxAccount.profileURL),
                                linkedDate: robloxAccount.linkedDate,
                                type: SocialNetworkType.roblox,
                                onTapUnlinkSocialAccount: presenter.onTapUnlinkRobloxAccount,
                              ),
                          ],
                        ),
                      ],
                    ),
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
      ),
    );
  }
}
