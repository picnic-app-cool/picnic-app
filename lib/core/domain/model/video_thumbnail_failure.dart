import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class VideoThumbnailFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const VideoThumbnailFailure.unknown([this.cause]) : type = VideoThumbnailsFailureType.unknown;

  final VideoThumbnailsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case VideoThumbnailsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'VideoThumbnailsFailure{type: $type, cause: $cause}';
}

enum VideoThumbnailsFailureType {
  unknown,
}
