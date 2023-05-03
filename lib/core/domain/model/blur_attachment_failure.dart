import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class BlurAttachmentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const BlurAttachmentFailure.unknown([this.cause]) : type = BlurAttachmentFailureType.unknown;

  final BlurAttachmentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case BlurAttachmentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'BlurAttachmentFailure{type: $type, cause: $cause}';
}

enum BlurAttachmentFailureType {
  unknown,
}
