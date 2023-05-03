import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class CancelSeedsOfferFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CancelSeedsOfferFailure.unknown([this.cause]) : type = CancelSeedsOfferFailureType.unknown;

  final CancelSeedsOfferFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CancelSeedsOfferFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'CancelSeedsOfferFailure{type: $type, cause: $cause}';
}

enum CancelSeedsOfferFailureType {
  unknown,
}
