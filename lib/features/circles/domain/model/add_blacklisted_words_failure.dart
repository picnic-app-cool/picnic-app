import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class AddBlacklistedWordsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const AddBlacklistedWordsFailure.unknown([this.cause]) : type = AddBlacklistedWordsFailureType.unknown;

  final AddBlacklistedWordsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case AddBlacklistedWordsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'AddBlacklistedWordsFailure{type: $type, cause: $cause}';
}

enum AddBlacklistedWordsFailureType {
  unknown,
}
