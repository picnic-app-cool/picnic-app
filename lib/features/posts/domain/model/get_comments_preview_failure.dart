import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCommentsPreviewFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCommentsPreviewFailure.unknown([this.cause]) : type = GetCommentsPreviewFailureType.unknown;

  final GetCommentsPreviewFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCommentsPreviewFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCommentsPreviewFailure{type: $type, cause: $cause}';
}

enum GetCommentsPreviewFailureType {
  unknown,
}
