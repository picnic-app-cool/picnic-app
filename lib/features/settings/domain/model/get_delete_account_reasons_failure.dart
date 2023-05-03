import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetDeleteAccountReasonsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetDeleteAccountReasonsFailure.unknown([this.cause]) : type = GetDeleteAccountReasonsFailureType.unknown;

  final GetDeleteAccountReasonsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetDeleteAccountReasonsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetDeleteAccountReasonsFailure{type: $type, cause: $cause}';
}

enum GetDeleteAccountReasonsFailureType {
  unknown,
}
