import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetRoyaltyFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetRoyaltyFailure.unknown([this.cause]) : type = GetRoyaltyFailureType.unknown;

  final GetRoyaltyFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetRoyaltyFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetRoyaltyFailure{type: $type, cause: $cause}';
}

enum GetRoyaltyFailureType {
  unknown,
}
