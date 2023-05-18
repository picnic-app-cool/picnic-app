// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presentation_model.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presenter.dart';
import 'package:picnic_app/features/seeds/widgets/candidates_list_widget.dart';
import 'package:picnic_app/features/seeds/widgets/select_director_button_widget.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
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
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() => presenter.onUserSearch(_controller.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    final appBar = PicnicAppBar(
      child: Text(
        appLocalizations.circleElectionVoteForDirector,
        style: theme.styles.body30,
      ),
    );

    final bwTitle30 = theme.styles.title30.copyWith(color: blackAndWhite.shade900);
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(12),
            PicnicSoftSearchBar(
              hintText: appLocalizations.search,
              controller: _controller,
            ),
            const Gap(18),
            Text(
              appLocalizations.circleElectionSelectSingleDirector,
              style: bwTitle30,
            ),
            const Gap(12),
            stateObserver(
              buildWhen: (previous, current) =>
                  previous.candidates != current.candidates || previous.selectedCandidate != current.selectedCandidate,
              builder: (context, state) => CandidatesListWidget(
                candidates: state.candidates,
                selectedCandidate: state.selectedCandidate,
                loadMore: presenter.onGetElectionCandidates,
                onTapCandidate: presenter.onTapDirector,
                isTopCandidatesView: false,
              ),
            ),
            stateObserver(
              builder: (context, state) => SafeArea(
                child: SelectDirectorButtonWidget(
                  onTap: state.voteEnabled ? presenter.onVoteForDirector : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
