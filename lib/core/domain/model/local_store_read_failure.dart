import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class LocalStoreReadFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LocalStoreReadFailure.unknown([this.cause]) : type = LocalStoreReadFailureType.unknown;

  final LocalStoreReadFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LocalStoreReadFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'LocalStoreReadFailure{type: $type, cause: $cause}';
}

enum LocalStoreReadFailureType {
  unknown,
}
