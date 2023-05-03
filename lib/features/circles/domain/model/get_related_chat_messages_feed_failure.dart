import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetRelatedChatMessagesFeedFailure implements HasDisplayableFailure {
  const GetRelatedChatMessagesFeedFailure.unknown([this.cause])
      // ignore: avoid_field_initializers_in_const_classes
      : type = GetRelatedMessagesFeedFailureType.unknown;

  final GetRelatedMessagesFeedFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetRelatedMessagesFeedFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetRelatedChatMessagesFeedFailure{type: $type, cause: $cause}';
}

enum GetRelatedMessagesFeedFailureType {
  unknown,
}
