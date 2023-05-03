import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetChatsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetChatsFailure.unknown([this.cause]) : type = GetChatsFailureType.unknown;

  final GetChatsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetChatsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetChatsFailure{type: $type, cause: $cause}';
}

enum GetChatsFailureType {
  unknown,
}
