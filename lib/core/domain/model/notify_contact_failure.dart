import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class NotifyContactFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const NotifyContactFailure.unknown([this.cause]) : type = NotifyContactFailureType.unknown;

  final NotifyContactFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case NotifyContactFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'NotifyContactFailure{type: $type, cause: $cause}';
}

enum NotifyContactFailureType {
  unknown,
}
