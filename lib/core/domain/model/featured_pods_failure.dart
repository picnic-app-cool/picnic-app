import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class FeaturedPodsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const FeaturedPodsFailure.unknown([this.cause]) : type = FeaturedPodsFailureType.unknown;

  final FeaturedPodsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case FeaturedPodsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'FeaturedPodsFailure{type: $type, cause: $cause}';
}

enum FeaturedPodsFailureType {
  unknown,
}
