import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCollectionsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCollectionsFailure.unknown([this.cause]) : type = GetCollectionsFailureType.unknown;

  final GetCollectionsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCollectionsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCollectionsFailure{type: $type, cause: $cause}';
}

enum GetCollectionsFailureType {
  unknown,
}
