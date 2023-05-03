import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class CopyTextFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CopyTextFailure.unknown([this.cause]) : type = CopyTextFailureType.unknown;

  final CopyTextFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CopyTextFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'CopyTextFailure{type: $type, cause: $cause}';
}

enum CopyTextFailureType {
  unknown,
}
