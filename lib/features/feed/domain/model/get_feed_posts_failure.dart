import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetFeedPostsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetFeedPostsFailure.unknown([this.cause]) : type = GetFeedPostsFailureType.unknown;

  final GetFeedPostsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetFeedPostsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetFeedPostsFailure{type: $type, cause: $cause}';
}

enum GetFeedPostsFailureType {
  unknown,
}
