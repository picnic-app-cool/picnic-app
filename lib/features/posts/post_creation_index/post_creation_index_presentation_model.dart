import 'dart:ui';

import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/camera_permission_info.dart';
import 'package:picnic_app/features/posts/domain/post_creation_preview_type.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_initial_params.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PostCreationIndexPresentationModel implements PostCreationIndexViewModel {
  /// Creates the initial state
  PostCreationIndexPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PostCreationIndexInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : type = PostCreationPreviewType.image,
        featureFlags = featureFlagsStore.featureFlags,
        contactsPermission = RuntimePermissionStatus.unknown,
        cameraPermissionInfo = const CameraPermissionInfo.empty(),
        cameraController = PicnicCameraController(getIt()),
        circle = initialParams.circle;

  /// Used for the copyWith method
  PostCreationIndexPresentationModel._({
    required this.type,
    required this.featureFlags,
    required this.contactsPermission,
    required this.cameraPermissionInfo,
    required this.cameraController,
    required this.circle,
  });

  final PostCreationPreviewType type;
  final FeatureFlags featureFlags;

  @override
  final RuntimePermissionStatus contactsPermission;

  @override
  final CameraPermissionInfo cameraPermissionInfo;

  @override
  final PicnicCameraController cameraController;

  @override
  final Circle? circle;

  Id get preselectedCircleId => circle?.id ?? const Id.empty();

  @override
  List<PostCreationPreviewType> get types => [
        if (featureFlags[FeatureFlagType.linkPostCreationEnabled]) PostCreationPreviewType.link,
        if (featureFlags[FeatureFlagType.imagePostCreationEnabled]) PostCreationPreviewType.image,
        if (featureFlags[FeatureFlagType.videoPostCreationEnabled]) PostCreationPreviewType.video,
        if (featureFlags[FeatureFlagType.pollPostCreationEnabled]) PostCreationPreviewType.poll,
        if (featureFlags[FeatureFlagType.textPostCreationEnabled]) PostCreationPreviewType.text,
      ];

  @override
  PostCreationPreviewType get selectedType => type;

  @override
  Brightness get getPostCreationBarBrightness {
    final imagePostingEnabled = circle?.imagePostingEnabled ?? true;
    if (selectedType == PostCreationPreviewType.image && !imagePostingEnabled) {
      return Brightness.dark;
    }
    final videoPostingEnabled = circle?.videoPostingEnabled ?? true;
    if (selectedType == PostCreationPreviewType.video && !videoPostingEnabled) {
      return Brightness.dark;
    }
    return selectedType.darkBackground ? Brightness.light : Brightness.dark;
  }

  @override
  bool get isFullScreen {
    final imagePostingEnabled = circle?.imagePostingEnabled ?? true;
    if (selectedType == PostCreationPreviewType.image && !imagePostingEnabled) {
      return false;
    }
    final videoPostingEnabled = circle?.videoPostingEnabled ?? true;
    if (selectedType == PostCreationPreviewType.video && !videoPostingEnabled) {
      return false;
    }
    return selectedType.fullscreen;
  }

  @override
  bool get nativeMediaPickerInPostCreationEnabled =>
      featureFlags[FeatureFlagType.nativeMediaPickerInPostCreationEnabled];

  PostCreationIndexPresentationModel copyWith({
    PostCreationPreviewType? type,
    FeatureFlags? featureFlags,
    RuntimePermissionStatus? contactsPermission,
    CameraPermissionInfo? cameraPermissionInfo,
    PicnicCameraController? cameraController,
    Circle? circle,
  }) {
    return PostCreationIndexPresentationModel._(
      type: type ?? this.type,
      featureFlags: featureFlags ?? this.featureFlags,
      contactsPermission: contactsPermission ?? this.contactsPermission,
      cameraPermissionInfo: cameraPermissionInfo ?? this.cameraPermissionInfo,
      cameraController: cameraController ?? this.cameraController,
      circle: circle ?? this.circle,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PostCreationIndexViewModel {
  PicnicCameraController get cameraController;

  PostCreationPreviewType get selectedType;

  List<PostCreationPreviewType> get types;

  bool get nativeMediaPickerInPostCreationEnabled;

  CameraPermissionInfo get cameraPermissionInfo;

  RuntimePermissionStatus get contactsPermission;

  Circle? get circle;

  Brightness get getPostCreationBarBrightness;

  bool get isFullScreen;
}
