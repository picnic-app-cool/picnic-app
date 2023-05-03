import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class AcceptSeedsOfferFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const AcceptSeedsOfferFailure.unknown([this.cause]) : type = AcceptSeedsOfferFailureType.unknown;

  final AcceptSeedsOfferFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case AcceptSeedsOfferFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'AcceptSeedsOfferFailure{type: $type, cause: $cause}';
}

enum AcceptSeedsOfferFailureType {
  unknown,
}
