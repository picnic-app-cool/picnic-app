import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetSavedPodsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetSavedPodsFailure.unknown([this.cause]) : type = GetSavedPodsFailureType.unknown;

  final GetSavedPodsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetSavedPodsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetSavedPodsFailure{type: $type, cause: $cause}';
}

enum GetSavedPodsFailureType {
  unknown,
}
