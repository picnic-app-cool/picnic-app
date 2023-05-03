import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class RequestDeleteAccountFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const RequestDeleteAccountFailure.unknown([this.cause]) : type = DeleteAccountRequestFailureType.unknown;

  final DeleteAccountRequestFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case DeleteAccountRequestFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'DeleteAccountRequestFailure{type: $type, cause: $cause}';
}

enum DeleteAccountRequestFailureType {
  unknown,
}
