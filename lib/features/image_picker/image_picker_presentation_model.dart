import 'package:picnic_app/core/domain/device_platform.dart';
import 'package:picnic_app/core/utils/device_platform_provider.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/image_picker/utils/image_source_type.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ImagePickerPresentationModel implements ImagePickerViewModel {
  /// Creates the initial state
  ImagePickerPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ImagePickerInitialParams initialParams,
    DevicePlatformProvider devicePlatformProvider,
  ) : devicePlatform = devicePlatformProvider.currentPlatform;

  /// Used for the copyWith method
  ImagePickerPresentationModel._({required this.devicePlatform});

  final DevicePlatform devicePlatform;

  @override
  List<ImageSourceType> get availableOptions => [
        if (devicePlatform == DevicePlatform.android || devicePlatform == DevicePlatform.ios) ImageSourceType.camera,
        ImageSourceType.gallery,
      ];

  ImagePickerPresentationModel copyWith({DevicePlatform? devicePlatform}) {
    return ImagePickerPresentationModel._(
      devicePlatform: devicePlatform ?? this.devicePlatform,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ImagePickerViewModel {
  List<ImageSourceType> get availableOptions;
}
