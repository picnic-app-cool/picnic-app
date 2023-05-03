import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class ImageWatermarkFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ImageWatermarkFailure.unknown([this.cause]) : type = ImageWatermarkFailureType.unknown;

  final ImageWatermarkFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case ImageWatermarkFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'ImageWatermarkFailure{type: $type, cause: $cause}';
}

enum ImageWatermarkFailureType {
  unknown,
}
