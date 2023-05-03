import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class RejectSeedsOfferFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const RejectSeedsOfferFailure.unknown([this.cause]) : type = RejectSeedsOfferFailureType.unknown;

  final RejectSeedsOfferFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case RejectSeedsOfferFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'RejectSeedsOfferFailure{type: $type, cause: $cause}';
}

enum RejectSeedsOfferFailureType {
  unknown,
}
