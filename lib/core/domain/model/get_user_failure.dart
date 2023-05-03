import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUserFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetUserFailure.unknown([this.cause]) : type = GetUserFailureType.unknown;

  final GetUserFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUserFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetUserFailure{type: $type, cause: $cause}';
}

enum GetUserFailureType {
  unknown,
}
