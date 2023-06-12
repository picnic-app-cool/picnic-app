import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class ViewCircleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ViewCircleFailure.unknown([this.cause]) : type = ViewCircleFailureType.unknown;

  final ViewCircleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case ViewCircleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'ViewCircleFailure{type: $type, cause: $cause}';
}

enum ViewCircleFailureType {
  unknown,
}
