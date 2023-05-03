import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class ViewPostFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ViewPostFailure.unknown([this.cause]) : type = ViewPostFailureType.unknown;

  final ViewPostFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case ViewPostFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'ViewPostFailure{type: $type, cause: $cause}';
}

enum ViewPostFailureType {
  unknown,
}
