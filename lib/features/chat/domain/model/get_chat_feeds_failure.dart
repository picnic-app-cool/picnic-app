//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetChatFeedsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetChatFeedsFailure.unknown([this.cause]) : type = GetChatFeedsFailureType.unknown;

  final GetChatFeedsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetChatFeedsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetChatFeedsFailure{type: $type, cause: $cause}';
}

enum GetChatFeedsFailureType {
  unknown,
}
