import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetInterestsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetInterestsFailure.unknown([this.cause]) : type = GetInterestsFailureType.unknown;

  final GetInterestsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetInterestsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetInterestsFailure{type: $type, cause: $cause}';
}

enum GetInterestsFailureType {
  unknown,
}
