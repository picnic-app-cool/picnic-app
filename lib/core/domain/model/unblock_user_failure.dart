import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UnblockUserFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UnblockUserFailure.unknown([this.cause]) : type = UnblockUserFailureType.unknown;

  final UnblockUserFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UnblockUserFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UnblockUserFailure{type: $type, cause: $cause}';
}

enum UnblockUserFailureType {
  unknown,
}
