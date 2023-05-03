import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class DiscoverFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const DiscoverFailure.unknown([this.cause]) : type = DiscoverFailureType.unknown;

  final DiscoverFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case DiscoverFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetFeedGroupsFailure{type: $type, cause: $cause}';
}

enum DiscoverFailureType {
  unknown,
}
