import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetSavedPostsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetSavedPostsFailure.unknown([this.cause]) : type = GetSavedPostsFailureType.unknown;

  final GetSavedPostsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetSavedPostsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetSavedPostsFailure{type: $type, cause: $cause}';
}

enum GetSavedPostsFailureType {
  unknown,
}
