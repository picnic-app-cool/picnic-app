import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class ResolveReportFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ResolveReportFailure.unknown([this.cause]) : type = ResolveReportFailureType.unknown;

  final ResolveReportFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case ResolveReportFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'ResolveReportFailure{type: $type, cause: $cause}';
}

enum ResolveReportFailureType {
  unknown,
}
