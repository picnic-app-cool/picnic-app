import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetDefaultCircleConfigFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetDefaultCircleConfigFailure.unknown([this.cause]) : type = GetDefaultCircleConfigFailureType.unknown;

  final GetDefaultCircleConfigFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetDefaultCircleConfigFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetDefaultCircleConfigFailure{type: $type, cause: $cause}';
}

enum GetDefaultCircleConfigFailureType {
  unknown,
}
