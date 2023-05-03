import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class RestartAppFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const RestartAppFailure.unknown([this.cause]) : type = RestartAppFailureType.unknown;

  final RestartAppFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case RestartAppFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'RestartAppFailure{type: $type, cause: $cause}';
}

enum RestartAppFailureType {
  unknown,
}
