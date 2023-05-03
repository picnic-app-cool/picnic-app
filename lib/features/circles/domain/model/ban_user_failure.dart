import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class BanUserFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const BanUserFailure.unknown([this.cause]) : type = BanUserFailureType.unknown;

  final BanUserFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case BanUserFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCircleDetailsFailure{type: $type, cause: $cause}';
}

enum BanUserFailureType {
  unknown,
}
