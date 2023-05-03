import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetFeatureFlagsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetFeatureFlagsFailure.unknown([this.cause]) : type = GetFeatureFlagsFailureType.unknown;

  final GetFeatureFlagsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetFeatureFlagsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetFeatureFlagsFailure{type: $type, cause: $cause}';
}

enum GetFeatureFlagsFailureType {
  unknown,
}
