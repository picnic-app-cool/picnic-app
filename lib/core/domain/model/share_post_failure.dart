import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SharePostFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SharePostFailure.unknown([this.cause]) : type = SharePostFailureType.unknown;

  final SharePostFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SharePostFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SharePostFailure{type: $type, cause: $cause}';
}

enum SharePostFailureType {
  unknown,
}
