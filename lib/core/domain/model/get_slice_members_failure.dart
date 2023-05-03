import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetSliceMembersFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetSliceMembersFailure.unknown([this.cause]) : type = GetSlicesFailureType.unknown;

  final GetSlicesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetSlicesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetSliceMembersFailure{type: $type, cause: $cause}';
}

enum GetSlicesFailureType {
  unknown,
}
