import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class TransferSeedsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const TransferSeedsFailure.unknown([this.cause]) : type = TransferSeedsFailureType.unknown;

  final TransferSeedsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case TransferSeedsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'TransferSeedsFailure{type: $type, cause: $cause}';
}

enum TransferSeedsFailureType {
  unknown,
}
