import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SavePostScreenTimeFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SavePostScreenTimeFailure.unknown([this.cause]) : type = SavePostScreenTimeFailureType.unknown;

  final SavePostScreenTimeFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SavePostScreenTimeFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SavePostScreenTimeFailure{type: $type, cause: $cause}';
}

enum SavePostScreenTimeFailureType {
  unknown,
}
