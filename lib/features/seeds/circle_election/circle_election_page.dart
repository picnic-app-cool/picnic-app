// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presentation_model.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presenter.dart';
import 'package:picnic_app/features/seeds/widgets/candidates_list_widget.dart';
import 'package:picnic_app/features/seeds/widgets/election_countdown_widget.dart';
import 'package:picnic_app/features/seeds/widgets/election_result_circular_progress.dart';
import 'package:picnic_app/features/seeds/widgets/select_director_button_widget.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleElectionPage extends StatefulWidget with HasPresenter<CircleElectionPresenter> {
  const CircleElectionPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CircleElectionPresenter presenter;

  @override
  State<CircleElectionPage> createState() => _CircleElectionPageState();
}

class _CircleElectionPageState extends State<CircleElectionPage>
    with PresenterStateMixin<CircleElectionViewModel, CircleElectionPresenter, CircleElectionPage> {
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

    final appBar = PicnicAppBar(
      actions: [
        PicnicContainerIconButton(
          iconPath: Assets.images.infoSquareOutlined.path,
          onTap: presenter.onTapInfo,
        ),
      ],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Flexible(
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

    final bwTitle30 = theme.styles.title30.copyWith(color: blackAndWhite.shade900);
    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(12),
          stateObserver(
            buildWhen: (previous, current) => previous.election != current.election,
            builder: (context, state) => ElectionResultCircularProgress(
              progress: state.electionProgress,
              seedsVoted: state.seedsVoted,
              showCircularProgress: state.showCircleProgressWidget,
            ),
          ),
          const Gap(12),
          stateObserver(
            buildWhen: (previous, current) => previous.election != current.election,
            builder: (context, state) => ElectionCountdownWidget(
              deadline: state.deadline,
              currentTimeProvider: state.currentTimeProvider,
              percentage: state.election.votesPercent,
            ),
          ),
          const Gap(18),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              appLocalizations.circleElectionSelectSingleDirector,
              style: bwTitle30,
            ),
          ),
          const Gap(12),
          stateObserver(
            buildWhen: (previous, current) =>
                previous.candidates != current.candidates || previous.selectedCandidate != current.selectedCandidate,
            builder: (context, state) => CandidatesListWidget(
              directors: state.candidates,
              selectedDirector: state.selectedCandidate,
              loadMore: presenter.onGetElectionCandidates,
              onTapDirector: presenter.onTapDirector,
            ),
          ),
          stateObserver(
            buildWhen: (previous, current) =>
                previous.selectedCandidate != current.selectedCandidate || previous.voted != current.voted,
            builder: (context, state) => SelectDirectorButtonWidget(
              isVoted: state.voted,
              onTap: state.voteEnabled ? presenter.onVoteForDirector : null,
            ),
          ),
        ],
      ),
    );
  }
}
