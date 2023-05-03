import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPostsInCollectionFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPostsInCollectionFailure.unknown([this.cause]) : type = GetPostsInCollectionFailureType.unknown;

  final GetPostsInCollectionFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPostsInCollectionFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPostsInCollectionFailure{type: $type, cause: $cause}';
}

enum GetPostsInCollectionFailureType {
  unknown,
}
