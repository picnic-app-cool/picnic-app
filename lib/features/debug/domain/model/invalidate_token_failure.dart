import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class InvalidateTokenFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const InvalidateTokenFailure.unknown([this.cause]) : type = InvalidateTokenFailureType.unknown;

  final InvalidateTokenFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case InvalidateTokenFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'InvalidateTokenFailure{type: $type, cause: $cause}';
}

enum InvalidateTokenFailureType {
  unknown,
}
