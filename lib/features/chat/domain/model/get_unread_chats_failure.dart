import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUnreadChatsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetUnreadChatsFailure.unknown([this.cause]) : type = GetUnreadChatsFailureType.unknown;

  final GetUnreadChatsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUnreadChatsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetUnreadChatsFailure{type: $type, cause: $cause}';
}

enum GetUnreadChatsFailureType {
  unknown,
}
