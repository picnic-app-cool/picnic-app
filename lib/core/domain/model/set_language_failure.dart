import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SetLanguageFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SetLanguageFailure.unknown([this.cause]) : type = SetLanguageFailureType.unknown;

  final SetLanguageFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SetLanguageFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SetLanguageFailure{type: $type, cause: $cause}';
}

enum SetLanguageFailureType {
  unknown,
}
