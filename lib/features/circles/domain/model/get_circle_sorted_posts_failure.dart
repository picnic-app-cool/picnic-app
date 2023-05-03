import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCircleSortedPostsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCircleSortedPostsFailure.unknown([this.cause]) : type = GetCircleSortedPostsFailureType.unknown;

  final GetCircleSortedPostsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCircleSortedPostsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCircleSortedPostsFailure{type: $type, cause: $cause}';
}

enum GetCircleSortedPostsFailureType {
  unknown,
}
