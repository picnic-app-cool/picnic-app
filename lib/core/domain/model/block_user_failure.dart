import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class BlockUserFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const BlockUserFailure.unknown([this.cause]) : type = BlockUserFailureType.unknown;

  final BlockUserFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case BlockUserFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'BlockUserFailure{type: $type, cause: $cause}';
}

enum BlockUserFailureType {
  unknown,
}
