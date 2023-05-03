import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPostsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPostsFailure.unknown([this.cause]) : type = GetPostsFailureType.unknown;

  final GetPostsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPostsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPostsFailure{type: $type, cause: $cause}';
}

enum GetPostsFailureType {
  unknown,
}
