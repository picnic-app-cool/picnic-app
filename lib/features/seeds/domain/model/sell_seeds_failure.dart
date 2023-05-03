import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SellSeedsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SellSeedsFailure.unknown([this.cause]) : type = SellSeedsFailureType.unknown;

  final SellSeedsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SellSeedsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SellSeedsFailure{type: $type, cause: $cause}';
}

enum SellSeedsFailureType {
  unknown,
}
