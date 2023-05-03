import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCommentByIdFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCommentByIdFailure.unknown([this.cause]) : type = GetCommentByIdFailureType.unknown;

  final GetCommentByIdFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCommentByIdFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCommentByIdFailure{type: $type, cause: $cause}';
}

enum GetCommentByIdFailureType {
  unknown,
}
