import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class AppInitFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const AppInitFailure.unknown([this.cause]) : type = AppInitFailureType.unknown;

  final AppInitFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case AppInitFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'AppInitFailure{type: $type, cause: $cause}';
}

enum AppInitFailureType {
  unknown,
}
