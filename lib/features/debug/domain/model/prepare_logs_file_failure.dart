import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class PrepareLogsFileFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const PrepareLogsFileFailure.unknown([this.cause]) : type = PrepareLogsFileFailureType.unknown;

  final PrepareLogsFileFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case PrepareLogsFileFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'PrepareLogsFileFailure{type: $type, cause: $cause}';
}

enum PrepareLogsFileFailureType {
  unknown,
}
