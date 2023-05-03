import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPostByIdFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPostByIdFailure.unknown([this.cause]) : type = GetPostByIdFailureType.unknown;

  final GetPostByIdFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPostByIdFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPostsFailure{type: $type, cause: $cause}';
}

enum GetPostByIdFailureType {
  unknown,
}
