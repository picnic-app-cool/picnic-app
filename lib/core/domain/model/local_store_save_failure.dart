import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class LocalStoreSaveFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LocalStoreSaveFailure.unknown([this.cause]) : type = LocalStoreSaveFailureType.unknown;

  final LocalStoreSaveFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LocalStoreSaveFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'LocalStoreSaveFailure{type: $type, cause: $cause}';
}

enum LocalStoreSaveFailureType {
  unknown,
}
