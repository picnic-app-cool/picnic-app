import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class LikeUnlikePostFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LikeUnlikePostFailure.unknown([this.cause]) : type = LikeUnlikePostFailureType.unknown;

  final LikeUnlikePostFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LikeUnlikePostFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'LikeUnlikePostFailure{type: $type, cause: $cause}';
}

enum LikeUnlikePostFailureType {
  unknown,
}
