import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SavePodFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SavePodFailure.unknown([this.cause]) : type = SavePodFailureType.unknown;

  final SavePodFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SavePodFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SavePodFailure{type: $type, cause: $cause}';
}

enum SavePodFailureType {
  unknown,
}
