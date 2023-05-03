import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';
import 'package:picnic_app/features/media_picker/utils/media_source_type.dart';
import 'package:picnic_app/resources/assets.gen.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class MediaPickerPresentationModel implements MediaPickerViewModel {
  /// Creates the initial state
  MediaPickerPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    MediaPickerInitialParams initialParams,
  )   : selectedAttachments = [],
        attachments = const PaginatedList.empty(),
        currentIndex = 0,
        cameraPermissionGranted = true,
        galleryPermissionGranted = true,
        microphonePermissionGranted = true,
        filePermissionGranted = true,
        permisionRequested = const FutureResult.empty();

  /// Used for the copyWith method
  MediaPickerPresentationModel._({
    required this.selectedAttachments,
    required this.attachments,
    required this.currentIndex,
    required this.cameraPermissionGranted,
    required this.galleryPermissionGranted,
    required this.microphonePermissionGranted,
    required this.filePermissionGranted,
    required this.permisionRequested,
  });

  @override
  final List<Attachment> selectedAttachments;

  @override
  final PaginatedList<Attachment> attachments;

  @override
  final int currentIndex;

  @override
  final bool cameraPermissionGranted;

  @override
  final bool galleryPermissionGranted;

  @override
  final bool microphonePermissionGranted;

  @override
  final bool filePermissionGranted;

  @override
  final FutureResult<void> permisionRequested;

  @override
  List<AssetGenImage> get menuIcons => [
        Assets.images.uploadPhoto,
        Assets.images.paper,
        Assets.images.takePhoto,
        Assets.images.takeVideo,
      ];

  Cursor get cursor => attachments.nextPageCursor(pageSize: Cursor.extendedPageSize);

  @override
  bool get allNecessaryPermissionsGranted {
    final mediaSource = MediaSourceType.from(currentIndex);
    if (mediaSource == MediaSourceType.cameraVideo) {
      return microphonePermissionGranted && cameraPermissionGranted;
    }
    if (mediaSource == MediaSourceType.cameraImage) {
      return cameraPermissionGranted;
    }
    return galleryPermissionGranted;
  }

  MediaPickerPresentationModel copyWith({
    List<Attachment>? selectedAttachments,
    PaginatedList<Attachment>? attachments,
    int? currentIndex,
    bool? cameraPermissionGranted,
    bool? galleryPermissionGranted,
    bool? microphonePermissionGranted,
    bool? filePermissionGranted,
    FutureResult<void>? permisionRequested,
  }) {
    return MediaPickerPresentationModel._(
      selectedAttachments: selectedAttachments ?? this.selectedAttachments,
      attachments: attachments ?? this.attachments,
      currentIndex: currentIndex ?? this.currentIndex,
      cameraPermissionGranted: cameraPermissionGranted ?? this.cameraPermissionGranted,
      galleryPermissionGranted: galleryPermissionGranted ?? this.galleryPermissionGranted,
      microphonePermissionGranted: microphonePermissionGranted ?? this.microphonePermissionGranted,
      filePermissionGranted: filePermissionGranted ?? this.filePermissionGranted,
      permisionRequested: permisionRequested ?? this.permisionRequested,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class MediaPickerViewModel {
  List<Attachment> get selectedAttachments;

  PaginatedList<Attachment> get attachments;

  int get currentIndex;

  List<AssetGenImage> get menuIcons;

  bool get galleryPermissionGranted;

  bool get cameraPermissionGranted;

  bool get microphonePermissionGranted;

  bool get allNecessaryPermissionsGranted;

  bool get filePermissionGranted;

  FutureResult<void> get permisionRequested;
}
