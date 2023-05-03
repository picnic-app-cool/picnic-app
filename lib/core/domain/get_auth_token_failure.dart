import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetAuthTokenFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetAuthTokenFailure.unknown([this.cause]) : type = GetAuthTokenFailureType.unknown;

  final GetAuthTokenFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetAuthTokenFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetAuthTokenFailure{type: $type, cause: $cause}';
}

enum GetAuthTokenFailureType {
  unknown,
}
