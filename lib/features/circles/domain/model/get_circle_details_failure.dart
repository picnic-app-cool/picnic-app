import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCircleDetailsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCircleDetailsFailure.unknown([this.cause]) : type = GetCircleDetailsFailureType.unknown;

  final GetCircleDetailsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCircleDetailsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCircleDetailsFailure{type: $type, cause: $cause}';
}

enum GetCircleDetailsFailureType {
  unknown,
}
