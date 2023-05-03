import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetSoundsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetSoundsFailure.unknown([this.cause]) : type = GetSoundsFailureType.unknown;

  final GetSoundsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetSoundsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetSoundsFailure{type: $type, cause: $cause}';
}

enum GetSoundsFailureType {
  unknown,
}
