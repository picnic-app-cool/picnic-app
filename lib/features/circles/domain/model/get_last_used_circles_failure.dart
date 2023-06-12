import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetLastUsedCirclesFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetLastUsedCirclesFailure.unknown([this.cause]) : type = GetLastUsedCirclesFailureType.unknown;

  final GetLastUsedCirclesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetLastUsedCirclesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetLastUsedCirclesFailure{type: $type, cause: $cause}';
}

enum GetLastUsedCirclesFailureType {
  unknown,
}
