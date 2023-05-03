import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UserPreferencesFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UserPreferencesFailure.unknown([this.cause]) : type = UserPreferencesFailureType.unknown;

  final UserPreferencesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UserPreferencesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UserPreferencesFailure{type: $type, cause: $cause}';
}

enum UserPreferencesFailureType {
  unknown,
}
