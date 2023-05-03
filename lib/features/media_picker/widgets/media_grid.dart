import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/media_picker/widgets/media_grid_item.dart';
import 'package:picnic_app/ui/widgets/paging_list/paging_grid_view.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class MediaGrid extends StatelessWidget {
  const MediaGrid({
    required this.attachments,
    required this.onTap,
    required this.loadMore,
    this.selectedAttachments = const [],
    super.key,
  });

  final PaginatedList<Attachment> attachments;
  final List<Attachment> selectedAttachments;
  final Function(Attachment) onTap;
  final Future<void> Function() loadMore;

  static const _crossAxisCount = 4;
  static const double _crossAxisSpacing = 2;
  static const double _mainAxisSpacing = 2;

  @override
  Widget build(BuildContext context) {
    return PagingGridView(
      paging: attachments,
      loadMore: loadMore,
      loadingBuilder: (_) => const PicnicLoadingIndicator(),
      itemBuilder: (context, index) {
        final attachment = attachments.items[index];
        return MediaGridItem(
          attachment: attachment,
          isSelected: selectedAttachments.contains(attachment),
          onTap: () => onTap(attachment),
        );
      },
      columns: _crossAxisCount,
      aspectRatio: 1.0,
      crossAxisSpacing: _crossAxisSpacing,
      mainAxisSpacing: _mainAxisSpacing,
    );
  }
}
