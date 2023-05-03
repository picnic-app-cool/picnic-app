import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SavePhotoToGalleryFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SavePhotoToGalleryFailure.unknown([this.cause]) : type = SavePhotoToGalleryFailureType.unknown;

  final SavePhotoToGalleryFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SavePhotoToGalleryFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SavePhotoToGalleryFailure{type: $type, cause: $cause}';
}

enum SavePhotoToGalleryFailureType {
  unknown,
}
