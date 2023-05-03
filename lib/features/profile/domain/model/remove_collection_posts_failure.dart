import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class RemoveCollectionPostsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const RemoveCollectionPostsFailure.unknown([this.cause]) : type = RemoveCollectionPostsFailureType.unknown;

  final RemoveCollectionPostsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case RemoveCollectionPostsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'RemoveCollectionPostsFailure{type: $type, cause: $cause}';
}

enum RemoveCollectionPostsFailureType {
  unknown,
}
