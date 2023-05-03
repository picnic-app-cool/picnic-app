import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UploadContactsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UploadContactsFailure.unknown([this.cause]) : type = UploadContactsFailureType.unknown;

  final UploadContactsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UploadContactsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UploadContactsFailure{type: $type, cause: $cause}';
}

enum UploadContactsFailureType {
  unknown,
}
