import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class CreateCollectionFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const CreateCollectionFailure.unknown([this.cause]) : type = CreateCollectionFailureType.unknown;

  final CreateCollectionFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case CreateCollectionFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'CreateCollectionFailure{type: $type, cause: $cause}';
}

enum CreateCollectionFailureType {
  unknown,
}
