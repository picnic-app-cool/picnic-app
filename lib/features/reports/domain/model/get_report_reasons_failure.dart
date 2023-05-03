//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetReportReasonsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetReportReasonsFailure.unknown([this.cause]) : type = GetReportReasonsFailureType.unknown;

  final GetReportReasonsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetReportReasonsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetReportReasonsFailure{type: $type, cause: $cause}';
}

enum GetReportReasonsFailureType {
  unknown,
}
