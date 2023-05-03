import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SaveVideoToGalleryFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SaveVideoToGalleryFailure.unknown([this.cause]) : type = SaveVideoToGalleryFailureType.unknown;

  final SaveVideoToGalleryFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SaveVideoToGalleryFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SaveVideoToGalleryFailure{type: $type, cause: $cause}';
}

enum SaveVideoToGalleryFailureType {
  unknown,
}
