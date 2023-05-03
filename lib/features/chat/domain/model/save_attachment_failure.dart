import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SaveAttachmentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SaveAttachmentFailure.unknown([this.cause]) : type = SaveAttachmentFailureType.unknown;

  final SaveAttachmentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SaveAttachmentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SaveAttachmentFailure{type: $type, cause: $cause}';
}

enum SaveAttachmentFailureType {
  unknown,
}
