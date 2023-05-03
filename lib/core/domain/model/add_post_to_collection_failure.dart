import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class AddPostToCollectionFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const AddPostToCollectionFailure.unknown([this.cause]) : type = AddPostToCollectionFailureType.unknown;

  final AddPostToCollectionFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case AddPostToCollectionFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'AddPostToCollectionFailure{type: $type, cause: $cause}';
}

enum AddPostToCollectionFailureType {
  unknown,
}
