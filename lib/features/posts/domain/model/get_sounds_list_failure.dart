import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetSoundsListFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetSoundsListFailure.unknown([this.cause]) : type = GetSoundsListFailureType.unknown;

  final GetSoundsListFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetSoundsListFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetSoundsListFailure{type: $type, cause: $cause}';
}

enum GetSoundsListFailureType {
  unknown,
}
