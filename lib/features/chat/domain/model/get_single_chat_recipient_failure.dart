import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetSingleChatRecipientFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetSingleChatRecipientFailure.unknown([this.cause]) : type = GetSingleChatRecipientFailureType.unknown;

  final GetSingleChatRecipientFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetSingleChatRecipientFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetSingleChatRecipientFailure{type: $type, cause: $cause}';
}

enum GetSingleChatRecipientFailureType {
  unknown,
}
