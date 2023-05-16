import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/select_circle/widgets/circle_list_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/empty_message_widget.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class CirclesListView extends StatelessWidget {
  const CirclesListView({
    super.key,
    required this.circles,
    required this.loadMore,
    required this.onTapCircle,
    required this.isEmpty,
    this.postType,
    this.onTapEnabled = false,
  });

  final Future<void> Function() loadMore;
  final ValueChanged<Circle> onTapCircle;
  final PaginatedList<Circle> circles;
  final bool isEmpty;
  final PostType? postType;
  final bool onTapEnabled;

  @override
  Widget build(BuildContext context) {
    const _topPadding = 4.0;
    return AnimatedSwitcher(
      duration: const ShortDuration(),
      child: isEmpty
          ? EmptyMessageWidget(
              message: appLocalizations.emptyUserCirclesMessage,
            )
          : PicnicPagingListView<Circle>(
              padding: EdgeInsets.only(
                top: _topPadding,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              paginatedList: circles,
              loadMore: loadMore,
              itemBuilder: (context, circle) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CircleListItem(
                  circle: circle,
                  onTap: () => onTapCircle(circle),
                ),
              ),
              loadingBuilder: (BuildContext context) => const PicnicLoadingIndicator(),
            ),
    );
  }
}
