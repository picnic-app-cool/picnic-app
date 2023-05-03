import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetBlockListFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetBlockListFailure.unknown([this.cause]) : type = GetBlockListFailureType.unknown;

  final GetBlockListFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetBlockListFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetBlockListFailure{type: $type, cause: $cause}';
}

enum GetBlockListFailureType {
  unknown,
}
