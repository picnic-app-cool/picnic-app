import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUserPostsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetUserPostsFailure.unknown([this.cause]) : type = GetUserPostsFailureType.unknown;

  final GetUserPostsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUserPostsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetUserPostsFailure{type: $type, cause: $cause}';
}

enum GetUserPostsFailureType {
  unknown,
}
