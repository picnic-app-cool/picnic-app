import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPostCreationCirclesFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPostCreationCirclesFailure.unknown([this.cause]) : type = GetPostCreationCirclesFailureType.unknown;

  final GetPostCreationCirclesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPostCreationCirclesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPostCreationCirclesFailure{type: $type, cause: $cause}';
}

enum GetPostCreationCirclesFailureType {
  unknown,
}
