import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_presentation_model.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_presenter.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';
import 'package:picnic_app/features/seeds/widgets/candidates_list_widget.dart';
import 'package:picnic_app/features/seeds/widgets/seeds_in_total_widget.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class CircleGovernancePage extends StatefulWidget with HasInitialParams {
  const CircleGovernancePage({
    super.key,
    required this.initialParams,
  });

  @override
  final CircleGovernanceInitialParams initialParams;

  @override
  State<CircleGovernancePage> createState() => _CircleGovernancePageState();
}

class _CircleGovernancePageState extends State<CircleGovernancePage>
    with PresenterStateMixinAuto<CircleGovernanceViewModel, CircleGovernancePresenter, CircleGovernancePage> {
  static const _avatarSize = 48.0;
  static const _emojiSize = 24.0;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final styles = theme.styles;
    final blackSubtitle = styles.title30.copyWith(color: blackAndWhite.shade900);

    final appBar = PicnicAppBar(
      actions: [
        PicnicContainerIconButton(
          iconPath: Assets.images.infoSquareOutlined.path,
          onTap: presenter.onTapInfo,
        ),
      ],
      child: Row(
        children: [
          const Gap(8),
          PicnicCircleAvatar(
            avatarSize: _avatarSize,
            emojiSize: _emojiSize,
            emoji: state.circle.emoji,
            image: state.circle.imageFile,
            bgColor: theme.colors.green.shade200,
          ),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.circle.name,
                  style: theme.styles.body30,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  appLocalizations.circleElectionDirectorElection,
                  style: theme.styles.caption10.copyWith(
                    color: blackAndWhite.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: stateObserver(
          builder: (context, state) {
            final userHasVoted = state.governance.myVotes.isNotEmpty;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 20,
                  ),
                  child: SeedsInTotalWidget(
                    seedsCount: state.governance.mySeedsCount,
                  ),
                ),
                Text(
                  appLocalizations.liveResults,
                  style: blackSubtitle,
                ),
                const Gap(8),
                CandidatesListWidget(
                  candidates: state.topCandidates,
                  selectedCandidate: const Selectable(item: VoteCandidate.empty()),
                  onTapCandidate: presenter.onTapCandidate,
                  loadMore: () => Future.value(),
                  isTopCandidatesView: true,
                ),
                const Gap(24),
                if (userHasVoted)
                  Text(
                    appLocalizations.myVote,
                    style: blackSubtitle,
                  ),
                const Gap(8),
                if (userHasVoted)
                  CandidatesListWidget(
                    candidates: state.candidatesIVoted,
                    selectedCandidate: const Selectable(item: VoteCandidate.empty()),
                    onTapCandidate: presenter.onTapCandidate,
                    loadMore: () => Future.value(),
                    isTopCandidatesView: true,
                  ),
                const Gap(20),
                if (state.governance.isSeedHolder)
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: PicnicButton(
                        title: userHasVoted
                            ? appLocalizations.circleElectionChangeVote
                            : appLocalizations.circleElectionVoteForDirector,
                        size: PicnicButtonSize.large,
                        onTap: presenter.onTapVoteForDirector,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
