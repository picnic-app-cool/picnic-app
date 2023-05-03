import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetChatMembersFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetChatMembersFailure.unknown([this.cause]) : type = GetChatMembersFailureType.unknown;

  final GetChatMembersFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetChatMembersFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetChatMembersFailure{type: $type, cause: $cause}';
}

enum GetChatMembersFailureType {
  unknown,
}
