import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPostCollectionsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPostCollectionsFailure.unknown([this.cause]) : type = GetPostCollectionsFailureType.unknown;

  final GetPostCollectionsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPostCollectionsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPostCollectionsFailure{type: $type, cause: $cause}';
}

enum GetPostCollectionsFailureType {
  unknown,
}
