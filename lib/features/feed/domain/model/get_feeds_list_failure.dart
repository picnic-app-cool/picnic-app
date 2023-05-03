import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetFeedsListFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetFeedsListFailure.unknown([this.cause]) : type = GetFeedsListFailureType.unknown;

  final GetFeedsListFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetFeedsListFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetFeedsListFailure{type: $type, cause: $cause}';
}

enum GetFeedsListFailureType {
  unknown,
}
