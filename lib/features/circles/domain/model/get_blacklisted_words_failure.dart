import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetBlacklistedWordsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetBlacklistedWordsFailure.unknown([this.cause]) : type = GetBlacklistedWordsFailureType.unknown;

  final GetBlacklistedWordsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetBlacklistedWordsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetBlacklistedWordsFailure{type: $type, cause: $cause}';
}

enum GetBlacklistedWordsFailureType {
  unknown,
}
