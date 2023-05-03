import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class RemoveBlacklistedWordsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const RemoveBlacklistedWordsFailure.unknown([this.cause]) : type = RemoveBlacklistedWordsFailureType.unknown;

  final RemoveBlacklistedWordsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case RemoveBlacklistedWordsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'RemoveBlacklistedWordsFailure{type: $type, cause: $cause}';
}

enum RemoveBlacklistedWordsFailureType {
  unknown,
}
