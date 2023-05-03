import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCommentsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCommentsFailure.unknown([this.cause]) : type = GetCommentsFailureType.unknown;

  final GetCommentsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCommentsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCommentsFailure{type: $type, cause: $cause}';
}

enum GetCommentsFailureType {
  unknown,
}
