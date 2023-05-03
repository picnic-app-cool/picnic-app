//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class CreateCircleReportFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CreateCircleReportFailure.unknown([this.cause]) : type = CreateCircleReportFailureType.unknown;

  final CreateCircleReportFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CreateCircleReportFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'CreateCircleReportFailure{type: $type, cause: $cause}';
}

enum CreateCircleReportFailureType {
  unknown,
}
