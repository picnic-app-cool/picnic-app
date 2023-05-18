import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';
import 'package:picnic_app/features/seeds/widgets/candidate_item_widget.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class CandidatesListWidget extends StatelessWidget {
  const CandidatesListWidget({
    Key? key,
    required this.candidates,
    required this.selectedCandidate,
    required this.loadMore,
    required this.onTapCandidate,
    required this.isTopCandidatesView,
  }) : super(key: key);

  final PaginatedList<VoteCandidate> candidates;
  final Selectable<VoteCandidate> selectedCandidate;
  final Future<void> Function() loadMore;
  final ValueChanged<VoteCandidate> onTapCandidate;
  final bool isTopCandidatesView;

  @override
  Widget build(BuildContext context) => Expanded(
        child: PicnicPagingListView<VoteCandidate>(
          paginatedList: candidates,
          loadMore: loadMore,
          loadingBuilder: (context) => const PicnicLoadingIndicator(),
          itemBuilder: (context, candidate) {
            return CandidateItemWidget(
              candidate: candidate,
              isSelected: selectedCandidate.selected && selectedCandidate.item == candidate,
              onTapCandidate: () => onTapCandidate(candidate),
              isTopCandidatesView: isTopCandidatesView,
            );
          },
        ),
      );
}
