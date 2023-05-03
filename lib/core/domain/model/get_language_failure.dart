import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetLanguageFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetLanguageFailure.unknown([this.cause]) : type = GetLanguagesFailureType.unknown;

  final GetLanguagesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetLanguagesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetLanguagesFailure{type: $type, cause: $cause}';
}

enum GetLanguagesFailureType {
  unknown,
}
