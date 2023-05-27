import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_presentation_model.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_presenter.dart';
import 'package:picnic_app/features/seeds/about_elections/widgets/how_it_works.dart';
import 'package:picnic_app/features/seeds/about_elections/widgets/how_to_get_seeds.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class AboutElectionsPage extends StatefulWidget with HasPresenter<AboutElectionsPresenter> {
  const AboutElectionsPage({
    super.key,
    required this.presenter,
  });

  @override
  final AboutElectionsPresenter presenter;

  @override
  State<AboutElectionsPage> createState() => _AboutElectionsPageState();
}

class _AboutElectionsPageState extends State<AboutElectionsPage>
    with PresenterStateMixin<AboutElectionsViewModel, AboutElectionsPresenter, AboutElectionsPage> {
  static const _seedsIconSize = 48.0;
  static const _electionIconSize = 48.0;
  static const _crownIconSize = 72.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final styles = theme.styles;
    final subtitle30style = styles.subtitle30.copyWith(
      color: colors.blackAndWhite.shade900,
    );
    final crownIcon = Assets.images.crownKing.path;
    final seedIcon = Assets.images.acorn.path;
    return stateObserver(
      builder: (context, state) => Scaffold(
        appBar: PicnicAppBar(showBackButton: !state.showConfirm),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(Assets.images.aboutElectionsHeader.path, fit: BoxFit.fitWidth),
                ),
                const Gap(12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appLocalizations.useSeedsToHelpCommunity,
                        style: theme.styles.title40.copyWith(
                          color: blackAndWhite.shade900,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        appLocalizations.seedsInCircle,
                        style: theme.styles.body30.copyWith(
                          color: PicnicColors.grey,
                        ),
                      ),
                      const Gap(24),
                      Container(
                        height: 1,
                        color: PicnicColors.lightGrey,
                      ),
                      const Gap(22),
                      Text(
                        appLocalizations.howItWorks,
                        style: subtitle30style,
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          Expanded(
                            child: HowItWorks(
                              text: appLocalizations.oneSeedOneVote,
                              iconPath: seedIcon,
                              iconSize: _seedsIconSize,
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            child: HowItWorks(
                              text: appLocalizations.voteOnDirectorMonthly,
                              iconPath: Assets.images.election.path,
                              iconSize: _electionIconSize,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      HowItWorks(
                        text: appLocalizations.mostVotesWin,
                        iconPath: crownIcon,
                        iconSize: _crownIconSize,
                      ),
                      const Gap(12),
                      Text(
                        appLocalizations.giveSeedsInCircle,
                        style: theme.styles.body20.copyWith(
                          color: colors.blackAndWhite.shade700,
                        ),
                      ),
                      const Gap(22),
                      Container(
                        height: 1,
                        color: PicnicColors.lightGrey,
                      ),
                      const Gap(22),
                      Text(
                        appLocalizations.howToGetSeeds,
                        style: subtitle30style,
                      ),
                      const Gap(12),
                      HowToGetSeeds(
                        text: appLocalizations.transferSeedsPossibility,
                        iconPath: crownIcon,
                      ),
                      const Gap(12),
                      HowToGetSeeds(
                        text: appLocalizations.seedsAreUnique,
                        iconPath: seedIcon,
                      ),
                      if (state.showConfirm)
                        Padding(
                          padding: const EdgeInsets.only(top: 22),
                          child: SizedBox(
                            width: double.infinity,
                            child: PicnicButton(
                              title: appLocalizations.confirmAction,
                              onTap: presenter.onTapContinue,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
