import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCircleByNameFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCircleByNameFailure.unknown([this.cause]) : type = GetCircleByNameFailureType.unknown;

  final GetCircleByNameFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCircleByNameFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCircleByNameFailure{type: $type, cause: $cause}';
}

enum GetCircleByNameFailureType {
  unknown,
}
