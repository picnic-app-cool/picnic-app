import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SaveAuthTokenFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SaveAuthTokenFailure.unknown([this.cause]) : type = SaveAuthTokenFailureType.unknown;

  final SaveAuthTokenFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SaveAuthTokenFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SaveAuthTokenFailure{type: $type, cause: $cause}';
}

enum SaveAuthTokenFailureType {
  unknown,
}
