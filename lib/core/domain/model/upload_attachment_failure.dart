import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UploadAttachmentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UploadAttachmentFailure.unknown([this.cause]) : type = UploadAttachmentFailureType.unknown;

  final UploadAttachmentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UploadAttachmentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UploadAttachmentFailure{type: $type, cause: $cause}';
}

enum UploadAttachmentFailureType {
  unknown,
}
