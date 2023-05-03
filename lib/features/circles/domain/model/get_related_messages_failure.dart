import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetRelatedMessagesFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetRelatedMessagesFailure.unknown([this.cause]) : type = GetRelatedMessagesFailureType.unknown;

  final GetRelatedMessagesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetRelatedMessagesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetRelatedMessagesFailure{type: $type, cause: $cause}';
}

enum GetRelatedMessagesFailureType {
  unknown,
}
