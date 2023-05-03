import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SavePostToCollectionFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SavePostToCollectionFailure.unknown([this.cause]) : type = SavePostToCollectionFailureType.unknown;

  final SavePostToCollectionFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SavePostToCollectionFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SavePostToCollectionFailure{type: $type, cause: $cause}';
}

enum SavePostToCollectionFailureType {
  unknown,
}
