//ignore_for_file: forbidden_import_in_presentation
import 'package:photo_manager/photo_manager.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ChooseMediaPresentationModel implements ChooseMediaViewModel {
  /// Creates the initial state
  ChooseMediaPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ChooseMediaInitialParams initialParams,
  )   : assetType = initialParams.assetType,
        attachments = const PaginatedList.empty();

  /// Used for the copyWith method
  ChooseMediaPresentationModel._({
    required this.attachments,
    required this.assetType,
  });

  final AssetType assetType;

  @override
  final PaginatedList<Attachment> attachments;

  Cursor get cursor => attachments.nextPageCursor(pageSize: Cursor.extendedPageSize);

  ChooseMediaPresentationModel copyWith({
    PaginatedList<Attachment>? attachments,
    AssetType? assetType,
  }) {
    return ChooseMediaPresentationModel._(
      attachments: attachments ?? this.attachments,
      assetType: assetType ?? this.assetType,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ChooseMediaViewModel {
  PaginatedList<Attachment> get attachments;
}
