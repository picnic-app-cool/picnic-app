import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/features/circles/circle_details/widgets/slice_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class SlicesTab extends StatelessWidget {
  const SlicesTab({
    Key? key,
    required this.onTapCreateSlice,
    required this.loadMore,
    required this.onTapJoinSlice,
    required this.sliceCount,
    required this.slices,
    required this.onTapSliceItem,
  }) : super(key: key);

  final VoidCallback onTapCreateSlice;
  final void Function(Slice slice) onTapJoinSlice;
  final Function(Slice) onTapSliceItem;
  final int sliceCount;
  final PaginatedList<Slice> slices;

  final Future<void> Function() loadMore;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(appLocalizations.sliceWithTopic(sliceCount), style: styles.subtitle40),
              PicnicTextButton(
                label: appLocalizations.createSliceAction,
                onTap: onTapCreateSlice,
                labelStyle: theme.styles.subtitle30.copyWith(color: theme.colors.blue),
              ),
            ],
          ),
          const Gap(8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PicnicPagingListView<Slice>(
                paginatedList: slices,
                loadMore: loadMore,
                loadingBuilder: (BuildContext context) => const Center(child: PicnicLoadingIndicator()),
                separatorBuilder: (context, index) => const Gap(16),
                itemBuilder: (BuildContext context, Slice slice) {
                  return SliceItem(
                    slice: slice,
                    onTapJoinSlice: () => onTapJoinSlice(slice),
                    onTapSliceItem: onTapSliceItem,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
