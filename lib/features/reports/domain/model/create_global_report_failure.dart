//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class CreateGlobalReportFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CreateGlobalReportFailure.unknown([this.cause]) : type = CreateReportFailureType.unknown;

  final CreateReportFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CreateReportFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'CreateGlobalReportFailure{type: $type, cause: $cause}';
}

enum CreateReportFailureType {
  unknown,
}
