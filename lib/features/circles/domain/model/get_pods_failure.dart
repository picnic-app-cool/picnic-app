import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPodsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPodsFailure.unknown([this.cause]) : type = GetPodsFailureType.unknown;

  final GetPodsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPodsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPodsFailure{type: $type, cause: $cause}';
}

enum GetPodsFailureType {
  unknown,
}
