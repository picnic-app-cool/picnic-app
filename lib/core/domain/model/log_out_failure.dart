import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class LogOutFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LogOutFailure.unknown([this.cause]) : type = LogOutFailureType.unknown;

  final LogOutFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LogOutFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'LogOutFailure{type: $type, cause: $cause}';
}

enum LogOutFailureType {
  unknown,
}
