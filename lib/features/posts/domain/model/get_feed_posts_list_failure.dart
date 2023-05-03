import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetFeedPostsListFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetFeedPostsListFailure.unknown([this.cause]) : type = GetPostsListFailureType.unknown;

  final GetPostsListFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPostsListFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPostsListFailure{type: $type, cause: $cause}';
}

enum GetPostsListFailureType {
  unknown,
}
