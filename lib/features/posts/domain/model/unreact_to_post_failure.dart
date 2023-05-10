import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UnreactToPostFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UnreactToPostFailure.unknown([this.cause]) : type = UnreactToPostFailureType.unknown;

  final UnreactToPostFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UnreactToPostFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UnreactToPostFailure{type: $type, cause: $cause}';
}

enum UnreactToPostFailureType {
  unknown,
}
