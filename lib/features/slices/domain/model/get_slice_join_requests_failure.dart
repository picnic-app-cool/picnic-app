import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetSliceJoinRequestsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetSliceJoinRequestsFailure.unknown([this.cause]) : type = GetSliceJoinRequestsFailureType.unknown;

  final GetSliceJoinRequestsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetSliceJoinRequestsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetSliceJoinRequestsFailure{type: $type, cause: $cause}';
}

enum GetSliceJoinRequestsFailureType {
  unknown,
}
